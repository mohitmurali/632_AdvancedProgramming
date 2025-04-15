package main

import (
    "fmt"
    "os"
    "log"
    "sync"
    "time"
)

// WorkUnit type represents a job with a numeric ID
type WorkUnit int

// JobExecutor processes jobs in a goroutine
func JobExecutor(executorNum int, workBuffer <-chan WorkUnit, outputStream chan<- string, waitSync *sync.WaitGroup) {
    defer waitSync.Done() // Constructor: Signal WaitGroup when done
    fmt.Println("Executor", executorNum, "began operation")
    for unit := range workBuffer {
        fmt.Println("Executor", executorNum, "processing unit", unit)
        time.Sleep(100 * time.Millisecond) // Simulate job processing
        result := fmt.Sprintf("Unit %d handled by Executor %d", unit, executorNum)
        outputStream <- result // Send result to output channel
    }
    fmt.Println("Executor", executorNum, "shut down")
}

// outputRecorder writes results to a file
func outputRecorder(outputStream <-chan string, completeChan chan<- struct{}) {
    fileHandle, err := os.Create("results.txt")
    if err != nil {
        log.Fatal("File creation failed:", err) // Terminate on file error
    }
    defer fileHandle.Close() // Ensure file is closed

    for result := range outputStream {
        fmt.Fprintln(fileHandle, result) // Write result to file
    }
    completeChan <- struct{}{} // Signal completion
}

// main function coordinates the processing system
func main() {
    const executorCount = 5 // Number of executors
    const unitCount = 20   // Number of work units
    workBuffer := make(chan WorkUnit, unitCount) // Buffered job channel
    outputStream := make(chan string, unitCount) // Buffered result channel
    var waitSync sync.WaitGroup                 // Synchronize executors
    completeChan := make(chan struct{})         // Signal recorder completion

    // Algorithm: Start result recorder
    // - Launches a goroutine to write results to file
    go outputRecorder(outputStream, completeChan)

    // Algorithm: Launch executors
    // - Start executorCount goroutines, each processing jobs
    for i := 0; i < executorCount; i++ {
        waitSync.Add(1)
        go JobExecutor(i, workBuffer, outputStream, &waitSync)
    }

    // Algorithm: Populate job channel
    // - Send unitCount jobs with IDs 0 to unitCount-1
    for i := 0; i < unitCount; i++ {
        workBuffer <- WorkUnit(i)
    }
    close(workBuffer) // Signal no more jobs

    // Algorithm: Wait for executors
    // - Block until all executors finish processing
    waitSync.Wait()
    close(outputStream) // Signal recorder to stop

    // Algorithm: Wait for recorder
    // - Ensure file writing completes before exit
    <-completeChan
    fmt.Println("All executors completed. Results in results.txt")
}
