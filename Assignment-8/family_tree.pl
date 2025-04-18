% Facts: Define the parent relationships in the family tree
% Each fact represents a parent-child relationship, e.g., parent(Parent, Child).
parent(elias, nadia).     % Elias is the parent of Nadia
parent(elias, selene).    % Elias is the parent of Selene
parent(mira, nadia).      % Mira is the parent of Nadia
parent(mira, selene).     % Mira is the parent of Selene
parent(nadia, lucian).    % Nadia is the parent of Lucian
parent(nadia, esme).      % Nadia is the parent of Esme
parent(victor, lucian).   % Victor is the parent of Lucian
parent(victor, esme).     % Victor is the parent of Esme
parent(selene, thalia).   % Selene is the parent of Thalia
parent(selene, cyrus).    % Selene is the parent of Cyrus
parent(dorian, thalia).   % Dorian is the parent of Thalia
parent(dorian, cyrus).    % Dorian is the parent of Cyrus

% Facts: Define gender for each individual
% male(Person) and female(Person) specify the gender of each family member.
male(elias).      % Elias is male
male(nadia).      % Nadia is male
male(lucian).     % Lucian is male
male(dorian).     % Dorian is male
male(cyrus).      % Cyrus is male
female(mira).     % Mira is female
female(victor).   % Victor is female
female(selene).   % Selene is female
female(esme).     % Esme is female
female(thalia).   % Thalia is female

% Rule: grandparent
% Defines a grandparent relationship where Grandparent is the parent of a Parent,
% who is the parent of a Grandchild.
grandparent(Grandparent, Grandchild) :- 
    parent(Grandparent, Parent),      % Grandparent is parent of Parent
    parent(Parent, Grandchild).       % Parent is parent of Grandchild

% Rule: sibling
% Defines a sibling relationship where Person1 and Person2 share at least one
% Parent and are distinct individuals.
sibling(Person1, Person2) :- 
    parent(Parent, Person1),          % Parent is parent of Person1
    parent(Parent, Person2),          % Parent is parent of Person2
    Person1 \= Person2.               % Person1 and Person2 are not the same

% Rule: cousin
% Defines a cousin relationship where Cousin1 and Cousin2 have parents who are
% siblings, and Cousin1 and Cousin2 are distinct.
cousin(Cousin1, Cousin2) :- 
    parent(Parent1, Cousin1),         % Parent1 is parent of Cousin1
    parent(Parent2, Cousin2),         % Parent2 is parent of Cousin2
    sibling(Parent1, Parent2),        % Parent1 and Parent2 are siblings
    Cousin1 \= Cousin2.               % Cousin1 and Cousin2 are not the same

% Rule: descendant (base case)
% Defines a descendant relationship where Descendant is a direct child of Ancestor.
descendant(Descendant, Ancestor) :- 
    parent(Ancestor, Descendant).     % Ancestor is parent of Descendant

% Rule: descendant (recursive case)
% Defines a descendant relationship where Descendant is a child of an Intermediate
% person, who is a descendant of Ancestor.
descendant(Descendant, Ancestor) :- 
    parent(Ancestor, Intermediate),   % Ancestor is parent of Intermediate
    descendant(Descendant, Intermediate). % Descendant is a descendant of Intermediate