public class LinearHashTable<T> extends HashTable<T>{



    protected int procPos(T s) {
        int index = s.hashCode() % numTable;

        if (index >= numTable || index < 0) {
            index = 0;

            if (HashTable[index] == null) {
                return index;
            } else {

                while (HashTable[index] != null && index + 1 < numTable) {
                    if (HashTable[index].valor.equals(s)) {
                        return index;
                    }
                    index += 1;
                }
                return index;


            }
        } else {
            if (HashTable[index] == null) {
                return index;
            } else {

                while (HashTable[index] != null && index + 1 < numTable) {
                    if (HashTable[index].valor.equals(s)) { return index;}
                    index += 1;
                }
                return index;


            }
        }
    }






    public static void main(String[] args) {

        LinearHashTable<Integer> table = new LinearHashTable<>();
        table.insere(21);
        table.insere(23);
        table.insere(24);
        table.insere(26);
        table.insere(3);
        table.insere(6);
        System.out.println(table.tamanhoTab());
        table.remove(3);
        System.out.println(table.procurar(3));
        table.print();
        System.out.println(table.factorCarga());

    }
}