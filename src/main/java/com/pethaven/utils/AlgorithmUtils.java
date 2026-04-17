package com.pethaven.utils;

import com.pethaven.model.Pet;
import java.util.ArrayList;
import java.util.List;

public class AlgorithmUtils {

    /**
     * MERGE SORT: Sorts pets by name (Alphabetical A-Z)
     * Complexity: O(n log n)
     */
    public static void mergeSort(List<Pet> pets) {
        if (pets == null || pets.size() <= 1) return;

        int mid = pets.size() / 2;
        List<Pet> left = new ArrayList<>(pets.subList(0, mid));
        List<Pet> right = new ArrayList<>(pets.subList(mid, pets.size()));

        mergeSort(left);
        mergeSort(right);
        merge(pets, left, right);
    }

    private static void merge(List<Pet> pets, List<Pet> left, List<Pet> right) {
        int i = 0, j = 0, k = 0;
        while (i < left.size() && j < right.size()) {
            // Compare pet names ignoring case
            if (left.get(i).getName().compareToIgnoreCase(right.get(j).getName()) <= 0) {
                pets.set(k++, left.get(i++));
            } else {
                pets.set(k++, right.get(j++));
            }
        }
        while (i < left.size()) pets.set(k++, left.get(i++));
        while (j < right.size()) pets.set(k++, right.get(j++));
    }

    /**
     * BINARY SEARCH: Finds a specific pet by name
     * Complexity: O(log n) - Requires a sorted list!
     */
    public static Pet binarySearch(List<Pet> pets, String targetName) {
        int low = 0;
        int high = pets.size() - 1;

        while (low <= high) {
            int mid = (low + high) / 2;
            int res = pets.get(mid).getName().compareToIgnoreCase(targetName);

            if (res == 0) {
                return pets.get(mid);
            } else if (res < 0) {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        return null; // Return null if not found
    }
}