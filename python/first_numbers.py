def convert_to_good_numbers(input_string):
    words = input_string.split()
    result_numbers = []
    for word in words:
        if '\\' in word and word.count('\\') == 1:
            parts = word.split('\\')
            if len(parts) == 2 :
                first_part = parts[0].zfill(4)
                second_part = parts[1].rstrip('.')
                second_part = second_part.zfill(5)
                good_number = f"{first_part}\\{second_part}"
                result_numbers.append(good_number)
    return '\n'.join(result_numbers)

input_string = "Адрес 5467\\456. Номер 0405\\00549."
result = convert_to_good_numbers(input_string)
print(result)
