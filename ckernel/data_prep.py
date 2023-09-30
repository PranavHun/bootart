#!/usr/bin/env python
"""
Data Preparation for CKernel - Matrix
"""
import numpy as np


class Data:
    """ Prints data as C array, which can be copy-pasted into the C Code """
    def __init__(self, total_columns, matrix_lines_per_column, max_tail_value):
        '''
        'columns' contains
        Matrix 1 head 1, 1 - tail 1, 2 - head 2, 3- tail 2 .....tail n,
        Matrix 2 head 1, ...
        .
        .
        m


        n - matrix_lines_per_column
        m - total_columns
        '''

        columns = []
        for colnum in range(total_columns):
            matrix_line = []
            for linenum in range(matrix_lines_per_column*2):
                matrix_line.append((max_tail_value // 2) * (colnum % 2) + np.random.randint(max_tail_value // 2))
            columns.extend(sorted(matrix_line))

        self.string = "int columns [] = {"
        self.string += ",".join([f" {x}" for x in columns])
        self.string += "};"

    def __repr__(self):
        return "repr"

    def __str__(self):
        """
        returns the self.column in the format which can be used in a C program.
        int columns [] = { column };\n
        """
        return self.string


if __name__ == "__main__":
    with open("data.h", "w") as data_file:
        data_file.write(str(Data(80, 10, 1024-25)))
