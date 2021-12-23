import java.util.*;
/* These are the names that Karim sent:
mohsen raki
zephan iel
afonso fohri
alof lari
anuja regli
corn elio
audam ar
noran nero
anish laro
silas fatsani
mina bartolome
nirmala themix
nassim farka
gennadius erna
silvijo sree
janna josefine
bert jia
machli jen
borja aong
chetana eef
washington dion
quint kai
aamina jaki
elenora andor
yuko rafa
paulo settimio
punit vladimir
marietta troph
laurentius andrea
filo pavi
ruska sachna
annabelle izumi
charis frang
ilker judo
balint gerhard
svanhild nout
marta whit
sweet gadisa
gillian hugh
bart mustafa
hektor fjolla
gwen abdullah
marianne cuthbert
alwin divina
sophronia eutro
prita mino
morris loui
polikarp alyona
clem laureniu
mabyn valentina
*/
public class Generate {
    public static void main(String[] args) throws Exception {
        Scanner sc = new Scanner(System.in);
        int id = 1;
        String[] faculty = {"\'Computer Science\'", "\'Pharmacy\'", "\'Management\'", "\'Electronics\'"};
        for (int i = 0; i < 30; i++) {
            String a = "\'" + sc.next() + "\'", b = "\'" + sc.next() + "\'";
            String type = i % 15 <= 7 ? "\'MSc\'" : "\'PhD\'";
            String fac = faculty[(int) (Math.random() * 4)];
            if (i < 15) {
                System.out.println("INSERT Into GucianStudent(id, firstName, lastName, type, faculty, address, GPA, undergradID)");
                System.out.println("Values(" + (id) + ", " + a + ", " + b + ", " + type + ", " + fac + ", " + randomAddress() + ", " + String.format("%.2f", Math.random() * 4) + ", " + randID() + ");");
            } else {
                System.out.println("INSERT Into NonGucianStudent(id, firstName, lastName, type, faculty, address, GPA)");
                System.out.println("Values(" + (id) + ", " + a + ", " + b + ", " + type + ", " + fac + ", " + randomAddress() + ", " + String.format("%.2f", Math.random() * 4) + ");");
            }

            System.out.println("INSERT INTO Thesis (serialNumber, field, type, title, startDate, endDate, defenseDate, grade, payment_id, noExtension)");
            System.out.println("Values(" + id + ", " + fac + ", " + type + ", " + ("\'" + fac.substring(1, fac.length()-1) + " Thesis" + "\'") + ", " + starDate(id) + ", " +
                    endDate(id) + ", " + defenseDate(id) + ", " + String.format("%.2f", Math.random() * 4) + ", " +
                    id + ", " + ((int) (Math.random() * 3)) + ");");
            id++;
        }
    }

    static String randomAddress() {
        int n = (int) (Math.random() * 5) + 6;
        char[] arr = new char[n];
        for (int i = 0; i < n; i++)
            arr[i] = (char) ('a' + (int) (Math.random() * 26));
        return "\'" + (new String(arr)) + " street" + "\'";
    }


    static String randID() {
        return "\'" + (int) (Math.random() * 40) + "-" + String.format("%04d", (int) (Math.random() * 10000)) + "\'";
    }

    static String starDate(int id){
        int year = 2017 + id/12;
        int month = (id - 1)%12 + 1;
        int day = (int) (Math.random() * 28 + 1);
        return "\'" + year + "-" + month + "-" + day + "\'";
    }

    static String endDate(int id){
        int year = 2018 + id/12;
        int month = (id - 1)%12 + 1;
        int day = (int) (Math.random() * 28 + 1);
        return "\'" + year + "-" + month + "-" + day + "\'";
    }

    static String defenseDate(int id){
        int year = 2019 + id/12;
        int month = (id - 1)%12 + 1;
        int day = (int) (Math.random() * 28 + 1);
        return "\'" + year + "-" + month + "-" + day + "\'";
    }
}