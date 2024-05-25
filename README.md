# Hexagonal-JSON-maze-solver

This project was done by me in the context of a programming competition at Concordia university.

The competition was one where each team was given the same four problems, and the teams had to solve the problems and present their solution to judges to gain points, all in about eight hours.

Our team of four was given the problems and we then decided to work on one problem each, but still helping each other if ever help was needed to solve the other's problem, for the sake of efficiency.

The problem I chose to solve was one where we were given information in a JSON format about tiles forming mazes that we simply had to solve. The tiles given were classified as types of NORMAL, WALL, START and END. This of course meant
that I was to find ANY solution that was in the form of a path only passing through NORMAL tiles and that started at the START tile and went to the END tile. Also, I will specify that there were four-hundred mazes given in the format of JSON files, classified
in four categories, all containing 100 of those 400 mazes, and the mazes each gave you different amount of points when you found the solution depending on which category that maze found itself in. The categories were easy, intermediate, hard and extreme.

Now it is correct for you to assume that the Hexagonal in the name of this repository serves a purpose and indeed you are right! The labyrinths tiles given were in fact meant to be displayed in a hexagonal manner, meaning that I had to learn how to use a new, to me, coordinate system.
This coordinate system is called the Hexagonal Efficient Coordinate System (HECS) and more information about it can be found on it's [Wikipedia page](https://en.wikipedia.org/wiki/Hexagonal_Efficient_Coordinate_System).

The first thing I had to do was choose which language or Platform I would use to solve the problem, and I ended up choosing GameMaker Studio 2 as I have a lot of experience using this software and I knew that it would make creating a vizualisation for my algorithm much easier.

Now, the tiles' information was given in a JSON file as I have previously mentionned, so I started by writing code to retrieve that information and then created objects which I placed on the screen by calculating their position in the rectangular coordinate system with formulas given on the 
HECS' Wikipedia page.

The algorithm I chose to implement to solve the mazes was a simple backtracking algorithm as I already had made up a pseudocode implementation in my head while reading the problem's explanation. The steps performed by my algorithm are the following:
<li>
  <ol>Go to the tile labelled as START</ol>
  <ol>Assess the tile(s) to which you can move to, and if the tile you are currently standing one has more that one path you can take, add the current tile to a stack of tiles called nodes</ol>
  <ol>Move to a random NORMAL (non-wall) adjacent tile which you have not explored, and add that tile to the list of tiles you have explored</ol>
  <ol>Repeat step two and three until you have nowhere to go, which is when you will then go back to the tile you get when removing the last tile off of the nodes tiles stack</ol>
  <ol>Stop the algorithm when you move to the END tile and return the solution as the tiles you have never backtracked onto.</ol>
</li>

This depth-first search (DFS) algorithm indeed looks easy when written as four basic steps, and I will agree with you that it is probably one of the easiest maze solving algorithms I could have chosen to implement, but the difficulty comes from the implementation of this 
algorithm in a program used to solve Hexagonal mazes, rather than a square-tiled maze.

I had considered implementing the A* algorithm, but I established that in the context of a competition with limited time, this decision would not give me the chance to finish within the alloted time period.

