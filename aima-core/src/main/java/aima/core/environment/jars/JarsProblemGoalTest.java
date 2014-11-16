package aima.core.environment.jars;

import aima.core.search.framework.GoalTest;

public class JarsProblemGoalTest implements GoalTest{

	JarsProblem goal = new JarsProblem(new JarsJar(4,2), new JarsJar(3,0));
	@Override
	public boolean isGoalState(Object state){
			JarsProblem board = (JarsProblem) state;
			return board.equals(goal);		
	}

}
