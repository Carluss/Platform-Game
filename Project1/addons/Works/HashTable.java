
public abstract class HashTable<T> {

    Elemento<T> HashTable[];

    private int size;

    int numTable;


    public class Elemento<T> {

        T valor;
        boolean tipo;

        Elemento<T> next;

        public Elemento(T valor) {
            this.valor = valor;
            this.tipo = false;
        }

        public T getValor() {
            return valor;
        }

        public boolean getTipo() {
            return tipo;
        }
    }

    public HashTable() {
        numTable = 11;
        HashTable = new Elemento[numTable];
        size = 0;



    }

    public HashTable(int i) {
        numTable = i;
        HashTable = new Elemento[numTable];
        size = 0;

        for (int x = 0; x < numTable; x++)
            HashTable[x] = null;

    }

    public int tamanhoTab(){return numTable ;}

    public int Ocupados() {
        return size;
    }

    public float factorCarga() { return (float)Ocupados() / numTable; }

    protected abstract int procPos(T s);

    public void alocarTabela(int dim) {
        HashTable = new Elemento[dim];
    }

    public void tornarVazia() {
        for (int i = 0; i < numTable; i++) {
            HashTable[i] = null;
        }
    }

    public T procurar(T x) {
        int index = procPos(x);
        if(HashTable[index].tipo){return null;}
        return HashTable[index].valor;
    }

    public void remove(T x) {
        if (HashTable[procPos(x)] != null) {
            if (HashTable[procPos(x)].valor.equals(x)) {
                HashTable[procPos(x)].tipo = true;
                size -= 1;
            }
        }
    }

    public void insere(T x) {

        Elemento n = new Elemento(x);

        if(HashTable[procPos(x)] != n){
            HashTable[procPos(x)] = n;
            size += 1;

        }


        if (factorCarga() >= 0.5) {
            rehash();
        }
    }

    public void rehash() {
        int sizeOr = numTable;
        int sizeDup = numTable * 2;
        int sizeNew = 0;

        for (int i = sizeDup; true; i++) {

            if (isPrimeNumber(i)) {
                sizeNew = i;
                break;
            }
        }

        Elemento<T> HashTableTemp[] = new Elemento[size];
        int iii=0;
        for (int i = 0; i < sizeOr ; i++) {
            if (HashTable[i] != null && !HashTable[i].tipo) {
                HashTableTemp[iii] = HashTable[i];
                iii++;
            }
        }

        size=0;
        numTable = sizeNew;
        HashTable = new Elemento[sizeNew];
        for (int i = 0; i < iii ; i++) {
            if (HashTableTemp[i] != null) {
                insere(HashTableTemp[i].valor);
            }
        }



    }

    private static boolean isPrimeNumber(int i) {
        int contador = 0;
        int j = 1;

        while(j <= i)
        {
            if(i % j == 0)
            {
                contador++;
                if (contador>2){break;}
            }
            j++;
        }
        return (contador == 2);
    }

    public void print(){
        for (int i = 0; i < numTable; i++ ) {
            if(HashTable[i] != null) {
                if(!HashTable[i].tipo){
                    System.out.println(HashTable[i].valor);
                }
            }
        }
    }

}