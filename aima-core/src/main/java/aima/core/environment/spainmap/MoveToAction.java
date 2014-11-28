package aima.core.environment.spainmap;

import aima.core.agent.impl.DynamicAction;

public class MoveToAction extends DynamicAction {
	public static final String ATTRIBUTE_MOVE_TO_LOCATION = "location";

	/** Defines the move to Action
	 * @param location  Location where we are going.
	 */
	public MoveToAction(String location) {
		super("moveTo");
		setAttribute(ATTRIBUTE_MOVE_TO_LOCATION, location);
	}

	public String getToLocation() {
		return (String) getAttribute(ATTRIBUTE_MOVE_TO_LOCATION);
	}
}
