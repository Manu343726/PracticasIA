package aima.core.jars;

public class JarsJar {
	
	private int _vol;
	private final int _maxVol;
	
	public JarsJar(int maxVolume){
		_maxVol = maxVolume; // Defines how much a jar can hold.
		_vol = 0; // The jar starts empty.
	}
	
	/** Fuction fills v litters into the jar, up to _maxVol
	 * @param v
	 * @return How much volume overflowed.
	 */
	public int fill(int v){
		_vol = _vol+v;
		if (_vol > _maxVol){
			int overflow = _maxVol - _vol; //Overflow calculation
			_vol = _maxVol;
			return overflow; 
		}
		return 0;
	}
	
	

}
