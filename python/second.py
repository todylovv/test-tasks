def minimize_distances(n, k, distances):
    while k > 0:
        max_distance = max(distances)

        if max_distance % 2 == 0:
            new_distances = [max_distance // 2] * 2
        else:
            new_distances = [max_distance // 2, max_distance // 2 + 1]

        index = distances.index(max_distance)
        distances.pop(index)
        for i, d in enumerate(new_distances):
            distances.insert(index + i, d)
        
        k -= 1

    return distances

n = 5
k = 3
initial_distances = [100, 180, 50, 60, 150]

result_distances = minimize_distances(n, k, initial_distances)
for distance in result_distances:
    print(distance)
