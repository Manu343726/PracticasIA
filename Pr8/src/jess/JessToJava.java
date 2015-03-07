package jess;

import java.util.Scanner;

import jess.Deffacts;
import jess.Fact;
import jess.JessException;
import jess.Rete;
import jess.Value;

public class JessToJava {
	private static Rete _rete;
	private static String _sourceFile;
	private static final Scanner read = new Scanner(System.in);
	private static final String[] MESSG = {
		"�En qu� �poca del a�o quiere viajar?",
		"�Cuanto es su presupuesto?",
		"�Tiene usted alguna afici�n?",
		"�Qu� edad tiene usted?",
		"�Viajar� acompa�ado?",
		"�Quiere un viaje ex�tico?",
		"�De qu� continente procede?",
		"�Qu� idioma habla?"
	};
	private static final String[] NOMVALUE ={
		"season",
		"budget",
		"hobby",
		"age",
		"companion",
		"exotic",
		"continent",
		"languages"		
	};
	
	/**
	 * Constructora de la clase, Inicializa rete y carga el clp.
	 */
	public JessToJava(){
		_rete = new Rete();
		_sourceFile = "viajes.clp";
		loadSource(_sourceFile);
	}
	
	/**
	 * Se encarga de cargar el clp en el rete
	 * 
	 * @param name el nombre del archivo
	 */
	public static void loadSource(String name){
		try{
			Value v = _rete.batch(name);
			System.out.println("Value :"+v);
		}catch (JessException je){
			System.out.println("Error al cargar");
			je.printStackTrace();
		}
	}
	
	public static void main(String[] args) throws JessException {
		JessToJava inst;
		inst = new JessToJava();
		treatInput(_rete);
		reset();
		_rete.setFocus("travelRecommendation");
		run();
		factList();
		halt();
	}
	
	public static void reset() {
		try {
			_rete.reset();
		} catch (JessException je2) {
			System.out.println("Error de reseteo ");

			je2.printStackTrace();
		}
	}
	
	public static void run() {
		try {
			_rete.run();
		} catch (JessException je4) {
			System.out.println("Error de ejecuci�n ");

			je4.printStackTrace();
		}
	}
	
	public static void halt() {
		try {
			_rete.halt();
		} catch (JessException je3) {
			System.out.println("Error de parada ");
		}
	}
	
	/**
	 * M�todo que se encarga de recoger la informaci�n del usuario y mandarsela al rete. 
	 * @param r la instancia de rete.
	 * @throws JessException
	 */
	private static void treatInput(Rete r) throws JessException{
		String userInput;
		Deffacts dff = new Deffacts ("usr", "", r); //Se define un deffacts llamado usr en las reglas 'r'
		Fact f = new Fact("user", r); //Se crea un nuevo fact del tipo User.
		Value[] val = new Value[MESSG.length];
		for(int i = 0; i<MESSG.length;i++){
			System.out.println(MESSG[i]);
			userInput = read.next();
			val[i] = new Value(Integer.parseInt(userInput));
			f.setSlotValue(NOMVALUE[i], val[i]); //a�ade el Slot con nombre NOMVALUE[i] con valor val[i] al fact de tipo user.
		}
		
		dff.addFact(f); //A�ade el fact al deffacts.
		r.addDeffacts(dff); //A�ade el deffacts a Rete.
		
	}
	
	public static void factList(){
		//TODO
		@SuppressWarnings("rawtypes")
		java.util.Iterator iterator;
		iterator = _rete.listFacts();
		Fact fetch = null;
		Fact[] fetchedTravels = new Fact[30];
		int travelCounter = 0;
		while (iterator.hasNext()){
			fetch = (Fact) iterator.next();
			if (fetch.getName().equals("MAIN::travelRecommendation")){
				if (!fetch.equals(null)){
					fetchedTravels[travelCounter]=fetch;
					travelCounter++;
				}
			}
		}
		try{
			System.out.println("Las recomendaciones de viajes son: ");
			for (int i = 0; i<3; i++){
				Value name = fetchedTravels[i].getSlotValue("name");
				Value begins = fetchedTravels[i].getSlotValue("begins");
				Value ends = fetchedTravels[i].getSlotValue("ends");
				Value cost = fetchedTravels[i].getSlotValue("cost");
				System.out.println("Viaje: " + name.stringValue(null));
				System.out.println("Comienza el: " + begins.stringValue(null));
				System.out.println("Acaba el: " + ends.stringValue(null));
				System.out.println("Precio: " + cost.stringValue(null));
			}
		}catch (JessException e3){
			System.err.println("Something went awefully wrong?!");
			e3.printStackTrace();
		}
	}
	
}
