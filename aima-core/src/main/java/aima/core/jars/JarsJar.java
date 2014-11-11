package aima.core.jars;

public class JarsJar {
	
	private int _vol;
	private final int _maxVol;
	
	/** Default constructor of Jar
	 * @param maxVolume How much the Jar can hold
	 */
	public JarsJar(int maxVolume){
		_maxVol = maxVolume;
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
		}else if (_vol<0){ //We can't have a bottle with a negative volume, can we?
			_vol = 0;
		}
		return 0;
	}
	
	public int getVolume(){
		return _vol;
	}
	
	public int getMax(){
		return _maxVol;
	}
	

}
