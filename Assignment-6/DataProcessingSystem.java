import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;
import java.io.PrintWriter;
import java.io.IOException;

// WorkUnit class represents a job with a unique identifier
class WorkUnit {
    private final int unitId;

    // Constructor: Initializes a work unit with its ID
    public WorkUnit(int unitId) {
        this.unitId = unitId;
    }

    // getUnitId: Returns the work unit's ID
    public int getUnitId() {
        return unitId;
    }
}

// JobExecutor class processes jobs in a separate thread
class JobExecutor implements Runnable {
    private final BlockingQueue<WorkUnit> workBuffer; // Shared queue for jobs
    private final PrintWriter outputStream; // Shared writer for results
    private final int executorNum; // Unique identifier for the executor

    // Constructor: Sets up executor with ID, queue, and writer
    public JobExecutor(int executorNum, BlockingQueue<WorkUnit> workBuffer, PrintWriter outputStream) {
        this.executorNum = executorNum;
        this.workBuffer = workBuffer;
        this.outputStream = outputStream;
    }

    // run: Processes jobs from the queue until termination
    @Override
    public void run() {
        System.out.println("Executor " + executorNum + " began operation");
        while (true) {
            try {
                // Retrieve a job, blocking if queue is empty
                WorkUnit unit = workBuffer.take();
                // Check for poison pill to stop executor
                if (unit.getUnitId() == -1) {
                    System.out.println("Executor " + executorNum + " shut down");
                    break;
                }
                System.out.println("Executor " + executorNum + " processing unit " + unit.getUnitId());
                // Simulate computational work with delay
                Thread.sleep(100);
                // Generate result string
                String resultLine = "Unit " + unit.getUnitId() + " handled by Executor " + executorNum;
                // Synchronize file writes to prevent race conditions
                synchronized (outputStream) {
                    outputStream.println(resultLine);
                }
            } catch (InterruptedException e) {
                // Log thread interruption errors
                System.err.println("Executor " + executorNum + " interrupted: " + e.getMessage());
                break;
            }
        }
    }
}

// DataProcessingSystem class manages the concurrent job processing system
public class DataProcessingSystem {
    // main: Entry point to set up and run the system
    public static void main(String[] args) {
        int executorCount = 5; // Number of executor threads
        int unitCount = 20; // Number of work units to process
        BlockingQueue<WorkUnit> workBuffer = new LinkedBlockingQueue<>(); // Shared job queue
        List<Thread> executorList = new ArrayList<>(); // List of executor threads

        try (PrintWriter outputStream = new PrintWriter("results.txt")) {
            // Algorithm: Populate queue with work units
            // - Loop adds units with IDs 0 to unitCount-1
            for (int i = 0; i < unitCount; i++) {
                workBuffer.put(new WorkUnit(i));
            }
            // Algorithm: Add poison pills to terminate executors
            // - One poison pill (unitId -1) per executor ensures clean shutdown
            for (int i = 0; i < executorCount; i++) {
                workBuffer.put(new WorkUnit(-1));
            }

            // Algorithm: Launch executor threads
            // - Create and start threads, each running a JobExecutor
            for (int i = 0; i < executorCount; i++) {
                Thread thread = new Thread(new JobExecutor(i, workBuffer, outputStream));
                executorList.add(thread);
                thread.start();
            }

            // Algorithm: Wait for completion
            // - Join all threads to ensure all jobs are processed before exit
            for (Thread thread : executorList) {
                thread.join();
            }
            System.out.println("All executors completed. Results in results.txt");
        } catch (IOException e) {
            // Log file operation errors
            System.err.println("Output error: " + e.getMessage());
        } catch (InterruptedException e) {
            // Log queue operation errors
            System.err.println("Main interrupted: " + e.getMessage());
        }
    }
}
