def largest_number(nums):
    nums.sort(key=lambda x: (x * 4)[:4], reverse=True)

    result = ''.join(nums)

    return result

input_strings = ["11", "234", "005", "89"]

result = largest_number(input_strings)
print(result)
