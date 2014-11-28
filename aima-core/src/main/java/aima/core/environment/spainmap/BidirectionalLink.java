package aima.core.environment.spainmap;

public class BidirectionalLink {

	private City _firstCity,_secondCity; 
	private int _roadDistance;
	
	/**
	 * Default Constructor, Should not be used.
	 */
	public BidirectionalLink(){
		_firstCity = new City();
		_secondCity = new City();
		_roadDistance = 0;
	}
	
	/** Parameter constructor for a bidirectional Link
	 * @param first One of the cities that are linked.
	 * @param second The other city that is linked.
	 * @param distance The distance of the road between them.
	 */
	public BidirectionalLink(City first, City second, int distance){
		_firstCity = first;
		_secondCity = second;
		_roadDistance = distance;
	}
	
	/** Checks the other side of the link.
	 * @param city the known city
	 * @return the city at the other end.
	 */
	public City getLinkedCity(City city){
		if (getFirstCity().equals(city)){
			return getSecondCity();
		}else if (getSecondCity().equals(city)){
			return getFirstCity();
		}
		return new City();
	}
	
	/** City getter
	 * @return One of the cities on the link.
	 */
	public City getFirstCity (){
		return _firstCity;
	}
	
	/** Citty getter
	 * @return The other city on the link.
	 */
	public City getSecondCity(){
		return _secondCity;
	}
	
	/** Distance getter
	 * @return Gets the real distance between two cities (not in a straight line, but the road length)
	 */
	public int getRoadDistance(){
		return _roadDistance;
	}
}
