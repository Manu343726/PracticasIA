package aima.core.environment.jars;

import aima.core.search.framework.HeuristicFunction;

/**
 * @author We do, we dooooooo
 * 
 */
public class SimpleHeuristic implements HeuristicFunction {

	public double h(Object state) {
		JarsProblem board = (JarsProblem) state;
		
		return Math.abs( 2 - board.getLeftJar().getVolume() );
	}
}
