package com.pethaven.utils;

// UTILITY & ALGORITHM LAYER: Custom sorting and searching algorithms.
// Coursework requirement: implement Merge Sort and Binary Search manually —
// do NOT use Collections.sort() or Arrays.binarySearch() here.

import com.pethaven.model.Pet;
import java.util.ArrayList;
import java.util.List;

public class AlgorithmUtils {

    // ─────────────────────────────────────────────────────────────────────────
    // ALGORITHM START: Coursework required Merge Sort logic goes here
    // Complexity: O(n log n) — divides the list in half recursively, then merges
    // Sorts pets alphabetically by name (case-insensitive, A → Z)
    // ─────────────────────────────────────────────────────────────────────────
    public static void mergeSort(List<Pet> pets) {
        // BASE CASE: A list of 0 or 1 element is already sorted — nothing to do
        if (pets == null || pets.size() <= 1) return;

        // DIVIDE: Split the list into two halves
        int mid = pets.size() / 2;
        List<Pet> left  = new ArrayList<>(pets.subList(0, mid));
        List<Pet> right = new ArrayList<>(pets.subList(mid, pets.size()));

        // CONQUER: Recursively sort each half
        mergeSort(left);
        mergeSort(right);

        // COMBINE: Merge the two sorted halves back into the original list
        merge(pets, left, right);
    }

    // MERGE HELPER: Combines two sorted sub-lists into one sorted list in-place.
    // Compares pet names character by character (ignoring case) to decide order.
    private static void merge(List<Pet> pets, List<Pet> left, List<Pet> right) {
        int i = 0; // pointer for left sub-list
        int j = 0; // pointer for right sub-list
        int k = 0; // pointer for the main list being rebuilt

        // Walk through both halves simultaneously, picking the smaller name each time
        while (i < left.size() && j < right.size()) {
            if (left.get(i).getName().compareToIgnoreCase(right.get(j).getName()) <= 0) {
                pets.set(k++, left.get(i++));  // left name comes first alphabetically
            } else {
                pets.set(k++, right.get(j++)); // right name comes first alphabetically
            }
        }

        // Drain any remaining elements from the left half
        while (i < left.size())  pets.set(k++, left.get(i++));

        // Drain any remaining elements from the right half
        while (j < right.size()) pets.set(k++, right.get(j++));
    }
    // ALGORITHM END: Merge Sort complete
    // ─────────────────────────────────────────────────────────────────────────


    // ─────────────────────────────────────────────────────────────────────────
    // ALGORITHM START: Coursework required Binary Search logic goes here
    // Complexity: O(log n) — halves the search space on every iteration
    // PRECONDITION: The list MUST be sorted by name before calling this method.
    //               Call mergeSort(pets) first if unsorted.
    // BOUNDARY CONDITION: If the name is not found, the loop exhausts the search
    //                     space (low > high) and returns null — no exception thrown.
    // ─────────────────────────────────────────────────────────────────────────
    public static Pet binarySearch(List<Pet> pets, String targetName) {
        // GUARD: Handle null/empty list or blank search term gracefully
        if (pets == null || pets.isEmpty() || targetName == null || targetName.isBlank()) {
            return null;
        }

        int low  = 0;
        int high = pets.size() - 1;

        // SEARCH LOOP: Keep narrowing the window until we find the target or run out of space
        while (low <= high) {
            int mid = (low + high) / 2;  // pick the middle index

            // Compare the middle pet's name to what we're looking for
            int comparison = pets.get(mid).getName().compareToIgnoreCase(targetName);

            if (comparison == 0) {
                // FOUND: Exact match (case-insensitive) — return this pet
                return pets.get(mid);
            } else if (comparison < 0) {
                // Middle name is alphabetically BEFORE target — search the right half
                low = mid + 1;
            } else {
                // Middle name is alphabetically AFTER target — search the left half
                high = mid - 1;
            }
        }

        // BOUNDARY CONDITION HANDLED: Search space exhausted, target name does not exist.
        // Returning null instead of throwing an exception — caller must check for null.
        return null;
    }
    // ALGORITHM END: Binary Search complete
    // ─────────────────────────────────────────────────────────────────────────
}
