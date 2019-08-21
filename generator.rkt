#lang racket

;; The number of rows and columns to generate.
(define n 5)

;; Create a board of n*n cells, initialised to a default value.
(define board (for/list ([i n])
                (for/list ([i n])
                  "x")))
