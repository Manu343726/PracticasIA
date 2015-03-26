//Pablo Mac-Veigh
//Manuel S�nchez

package jess;

import java.util.ArrayList;
import java.util.List;
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
		"�En qu� �poca del a�o quiere viajar? 0-Primavera, 1-Verano, 2-Oto�o, 3-Invierno",
		"�Cuanto es su presupuesto?",
		"�Tiene usted alguna afici�n? 0-Deportes, 1-Aventura,\n2-Cultura, 3-Turismo, 4-Gastronom�a",
		"�Qu� edad tiene usted?",
		"�Viajar� acompa�ado? 0-S�lo, 1-Familia, 2-Amigos",
		"�Quiere un viaje ex�tico? 0-No, 1-Si",
		"�De qu� continente procede? 0-Europa, 1-Asia, 2-Australia,\n3-America del Norte, 4-America del Sur",
		"�Qu� idioma habla 0-Esp, 1-Eng, 2-Fra, 3-Chn, 4-Ger, 5-Ind, 6-Por?"
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
		//factList(Integer.parseInt(args[0])); //Args should be 3 for 3 elements
		factList(3);
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
			try{
			System.out.println(MESSG[i]);
			userInput = read.next();
			val[i] = new Value(Integer.parseInt(userInput));
			f.setSlotValue(NOMVALUE[i], val[i]); //a�ade el Slot con nombre NOMVALUE[i] con valor val[i] al fact de tipo user.
			}catch (Exception e){
				System.out.println("Valor no valido, vuelva a empezar");
				treatInput(r);
			}
		}
		
		dff.addFact(f); //A�ade el fact al deffacts.
		r.addDeffacts(dff); //A�ade el deffacts a Rete.
		
	}
	
	public static List<Fact> filter(String template)
	{
		ArrayList<Fact> out = new ArrayList<Fact>();
		java.util.Iterator it = _rete.listFacts();
		
		while(it.hasNext())
		{
			Fact f = (Fact)it.next();
			
			if(f.getName().equalsIgnoreCase(template))
				out.add(f);
		}
		
		return out;
	}
	
	public static void factList(int maxResults){
		//TODO
		@SuppressWarnings("rawtypes")
		
		List<Fact> fetchedTravels = filter("MAIN::recommendation");
		
		try{
			System.out.println("Las recomendaciones de viajes son: \n");
			for (int i = 0; i< Math.min(maxResults,fetchedTravels.size()); i++){
				Value name = fetchedTravels.get(i).getSlotValue("name");
				Value description = fetchedTravels.get(i).getSlotValue("description");
				System.out.println("Viaje: " + name.stringValue(null));
				System.out.println("Descripci�n: " + description.stringValue(null) + "\n");
			}
			
			if(fetchedTravels.isEmpty())
				System.out.println("Lo sentimos, ningun viaje de nuestra base de datos se ajusta a sus necesidades");
			
		}catch (JessException e3){
			System.err.println("Something went awefully wrong?!");
			e3.printStackTrace();
		}
	}
	
}
