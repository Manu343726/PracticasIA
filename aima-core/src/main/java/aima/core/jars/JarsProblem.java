package aima.core.jars;

import aima.core.agent.Action;
import aima.core.agent.impl.DynamicAction;

public class JarsProblem {

	//Defining the possible actions in the problem:
	public static Action FILLLEFT = new DynamicAction("Fill Left"); //Fills the left jar.
	public static Action FILLRIGHT = new DynamicAction("Fill Right"); //Same for right.
	public static Action DUMPLEFT = new DynamicAction("Dump Left");  //Empties the left jar leaving the right one untouched.
	public static Action DUMPRIGHT = new DynamicAction("Dump Right"); //Same for right.
	public static Action POURLEFT = new DynamicAction("Pour Left"); //Empties the content from the left jar into the right, until left is empty or right is full
	public static Action POURRIGHT = new DynamicAction("Pour Right"); //Same for right.
	
	private JarsJar[] _state;
	
	/**
	 * Default constructor for the Jars problem; It creates two jars, one holding up to 4 litres, and the other one up to 3 litres.
	 */
	public JarsProblem(){
		_state = new JarsJar[2];
		_state[0] = new JarsJar(4);
		_state[1] = new JarsJar(3);
	}
	
	/**
	 * @return The actual state of the problem
	 */
	public JarsJar[] getState(){
		return _state;
	}
	
	/**
	 * Fills the left jar.
	 */
	public void fillLeft(){
		_state[0].fill(_state[0].getMax()); //You fill up to max.
	}
	
	/**
	 * Fills the right jar.
	 */
	public void fillRight(){
		_state[1].fill(_state[1].getMax()); //You fill up to max.
	}
	
	/**
	 * Empties the left Jar.
	 */
	public void dumpLeft(){
		_state[0].fill(-_state[0].getVolume()); //You 'fill' with the negative actual volume, resulting in 0;
	}
	
	/**
	 * Empties the right Jar.
	 */
	public void dumpRight(){
		_state[1].fill(-_state[1].getVolume()); //You 'fill' with the negative actual volume, resulting in 0;
	}
	
	/**
	 * Pours the content from the left jar into the right jar.
	 * After the fuction:
	 * 	-The left jar will have the same content, if the right jar was full, wich will remain that way.
	 * 	-The left jar will have less content, if the right jar had more space than the left side had volume, and the right jar will become full.
	 * 	-The left jar will be empty, if the right jar had enough space for it, wich will be either full, or partially filled.
	 */
	public void pourLeft(){
		if (_state[1].getVolume()==_state[1].getMax()){ //If the right jar is full
			//Do nothing, left won't change
		}else if(_state[1].getVolume()<_state[1].getMax()){ //If the right jar isn't full
			int maxPour = _state[1].getMax()-_state[1].getVolume();
			if (_state[0].getVolume()<=maxPour){ // If we can pour all the content
				_state[1].fill(_state[0].getVolume()); // We pour it
				dumpLeft(); // We empty the left jar
			}else{ // We just pour maxPour
				_state[1].fill(maxPour);
				_state[0].fill(-maxPour);
			}
		}
	}
	
	/**
	 * Pours the content from the right jar into the left jar.
	 * After the fuction:
	 * 	-The right jar will have the same content, if the left jar was full, wich will remain that way.
	 * 	-The right jar will have less content, if the left jar had more space than the right side had volume, and the left jar will become full.
	 * 	-The right jar will be empty, if the left jar had enough space for it, wich will be either full, or partially filled.
	 */
	public void pourRight(){
		if (_state[0].getVolume()==_state[0].getMax()){ //If the left jar is full
			//Do nothing, right won't change
		}else if(_state[0].getVolume()<_state[0].getMax()){ //If the left jar isn't full
			int maxPour = _state[0].getMax()-_state[0].getVolume();
			if (_state[1].getVolume()<=maxPour){ // If we can pour all the content
				_state[0].fill(_state[1].getVolume()); // We pour it
				dumpRight(); // We empty the right jar
			}else{ // We just pour maxPour
				_state[0].fill(maxPour);
				_state[1].fill(-maxPour);
			}
		}
	}
	
}
