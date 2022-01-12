void main (string[] args) {
    string read;
    try {
        FileUtils.get_contents (args[1], out read);
    } catch (GLib.FileError e) {
        return;
    }

    int[] numbers = {};

    foreach (string item in read.split (",")) {
        numbers += int.parse (item);
    }

    sort(numbers);

    int minfuel = int.MAX;

    foreach (int target in numbers) {
        int fuel = 0;
        foreach (int point in numbers) {
            int dist = (point - target).abs();
            fuel += (dist * (dist + 1)) / 2;
        }

        if (minfuel > fuel) {
            minfuel = fuel;
        } else if (minfuel != fuel) {
            break;
        }
    }

    print("%d\n", minfuel);
}

void sort(int[] array) {
    for (int i = 1; i < array.length; i++) {
        var val = array[i];
        var j = i;

        for ( ; j > 0 && val < array[j - 1]; j--) {
            array[j] = array[j - 1];
        }

        array[j] = val;
    }
}
