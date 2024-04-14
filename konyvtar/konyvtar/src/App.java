import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class App {
    public static void main(String[] args) throws Exception {
        if(args.length==0){
            System.out.println("Nem adott meg paramétereket!");
            System.out.println("Kérem paraméterként megadni először a Kolcsonzok.csv, majd a Kolcsonsesek.csv pontos helyét!");
            return;
        }
        if(args.length==1){
            System.out.println("Csak egy paramétert adott meg!");
            System.out.println("Kérem paraméterként megadni először a Kolcsonzok.csv, majd a Kolcsonsesek.csv pontos helyét!");
            return;
        }
        Class.forName("com.mysql.cj.jdbc.Driver");
        System.out.println(args[0]);
        File file = new File(args[0]);
        Scanner scan = new Scanner(file,"UTF-8");
        List<Kolcsonzok> list = new ArrayList<>();
        int kolcsonzokSum=0;
        int kolcsonzesekSum=0;
        scan.nextLine();
        while(scan.hasNextLine()){
            String line=scan.nextLine();
            String[] data=line.split(";");
            Kolcsonzok kolcsonzok=new Kolcsonzok();
            kolcsonzok.name=data[0];
            kolcsonzok.birth=data[1];
            list.add(kolcsonzok);
        }
        scan.close();
    
        File file2 = new File(args[1]);
        Scanner scan2 = new Scanner(file2,"UTF-8");
        List<Kolcsonsesek> list2= new ArrayList<>();
        scan2.nextLine();
        while(scan2.hasNextLine()){
            String line=scan2.nextLine();
            String[] data=line.split(";");
            Kolcsonsesek kolcsonsesek= new Kolcsonsesek();
            kolcsonsesek.KolcsonzoId = Integer.parseInt(data[0]);
            kolcsonsesek.Iro=data[1];
            kolcsonsesek.Mufaj=data[2];
            kolcsonsesek.Cim=data[3];
            list2.add(kolcsonsesek);
        }
        scan2.close();

        String url = "jdbc:mysql://localhost:3306";
        String username = "root";
        String password = "";
        Connection conn = DriverManager.getConnection(url, username, password);
        try{
            Statement stmt = conn.createStatement();
            stmt.executeUpdate("CREATE DATABASE IF NOT EXISTS konyvtar CHARACTER SET utf8 COLLATE utf8_hungarian_ci;");
            stmt.executeUpdate("use konyvtar;");
            stmt.executeUpdate("CREATE TABLE IF NOT EXISTS kolcsonzok (" +
            "id INT AUTO_INCREMENT PRIMARY KEY," +
            "name VARCHAR(255) NOT NULL," +
            "birth DATE NOT NULL" +
            ") CHARACTER SET utf8 COLLATE utf8_hungarian_ci;");
            stmt.executeUpdate("CREATE TABLE IF NOT EXISTS kolcsonsesek (" +
            "id INT AUTO_INCREMENT PRIMARY KEY," +
            "kolcsonzo_id INT NOT NULL," +
            "iro VARCHAR(255) NOT NULL," +
            "mufaj VARCHAR(255) NOT NULL," +
            "cim TEXT NOT NULL," +
            "FOREIGN KEY (kolcsonzo_id) REFERENCES kolcsonzok(id)" +
            ") CHARACTER SET utf8 COLLATE utf8_hungarian_ci");
            for (Kolcsonzok list3 : list) {
                stmt.executeUpdate("INSERT INTO kolcsonzok (name, birth) VALUES (\""+ list3.name + "\",\""+list3.birth+"\")");
                kolcsonzokSum++;
            }
            for (Kolcsonsesek list22 : list2) {
                stmt.executeUpdate(
                    "INSERT INTO kolcsonsesek (kolcsonzo_id, iro, mufaj, cim) VALUES ("+list22.KolcsonzoId+",\""+list22.Iro+"\","+"\""+list22.Mufaj+"\","+"\""+list22.Cim+"\")");
                    kolcsonzesekSum++;
            }
            stmt.close();
        }catch(Exception exception){
            System.err.println("Kérem paraméterként megadni először a Kolcsonzok.csv, majd a Kolcsonsesek.csv pontos helyét!");
        }
        System.out.println("A feltöltés végetért!");
        System.out.println("Sikeresen hozzáadott Kolcsozok száma: " + kolcsonzokSum);
        System.out.println("Sikeresen hozzáadott Kolcsonsesek száma: " + kolcsonzesekSum);
        System.out.println("Összes felvitt sorok száma: " + (kolcsonzesekSum+kolcsonzokSum));
    }
}
