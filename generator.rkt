#lang racket

;; The number of rows and columns to generate.
(define n 5)

;; Symbols for different kinds of cells.
(define tent "⛺️")
(define tree "🌳")
(define grass "G")
(define mud "X")

;; Create a board of n*n cells, initialised to a default value.
(define board (for/list ([i n])
                (for/list ([j n])
                  mud)))

;; Pretty-prints the board with extra spacing between cells.
(define (pretty-print-board board)
  (for ([row board])
    (for ([cell row])
      (display (format "~a  " cell)))
    (display "\n\n")))


(pretty-print-board board)
