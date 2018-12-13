public class QuadHashTable<T> extends HashTable<T> {


    protected int procPos(T s) {
        int index = s.hashCode() % numTable;

        if (index < 0 || index>numTable) {
            for (int i = 0; i < numTable;i=i*i) {
                if (HashTable[i] != null) { continue; }
                else {  index = i; }
            }

        }

        else {
            for (int i = index; i < numTable; i=i*i) {
                if (HashTable[i] != null) { continue; }
                else {  index = i; }
            }
        }

        return index;

    }
}
