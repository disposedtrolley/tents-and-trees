#lang racket

;; The number of rows and columns to generate.
(define n 5)

;; Symbols for different kinds of cells.
(struct cell (display-char large?))
(define tent (cell "⛺" #t))
(define tree (cell "🌳" #t))
(define grass (cell "G" #f))
(define mud (cell "X" #f))

;; Create a board of n*n cells, initialised to a default value.
(define board (for/list ([i n])
                (for/list ([j n])
                  mud)))

;; Pretty-prints the board with extra spacing between cells.
(define (pretty-print-board board)
  (for ([row board])
    (for ([cell row])
      (display (format
                (if (cell-large? cell) "~a " "~a  ")
                (cell-display-char cell))))
    (display "\n\n")))

;; Fills a cell on the board at the given column and row with a new
;; cell type.
(define (fill-cell board col row cell)
  (define row-to-update (list-ref board row))
  (define new-row (list-set row-to-update col cell))
  (define new-board (list-set board row new-row))
  new-board)

(pretty-print-board board)
(fill-cell board 0 0 tent)
(define new-board (fill-cell board 0 0 tent))
(pretty-print-board new-board)
