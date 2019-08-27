#lang racket
(require dyoo-while-loop)

;; CONFIGURATION
;; The number of rows and columns to generate.
(define board-size 5)
;; The number of trees to generate.
(define n-trees 10)

;; Symbols for different kinds of cells.
(struct cell (display-char large?))
(define tent (cell "⛺" #t))
(define tree (cell "🌳" #t))
(define grass (cell "G" #f))
(define mud (cell "X" #f))

;; Create a board of n*n cells, initialised to a default value.
(define board (for/list ([i board-size])
                (for/list ([j board-size])
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

;; Returns #t if list contains val, otherwise #f.
(define (contains list val)
  (not (false? (member val list))))

;; Fills the board with n number of trees.
(define (fill-trees board n)
  (define board-n (length board))
  (for ([i n])
    (define placed #f)
    (while (not placed)
      ;; Continue to randomly choose a location for the tree until a valid cell is chosen.
      (define col (random board-n))
      (define row (random board-n))

      (define row-to-update (list-ref board row))

      (define horizontal-spaces (count identity
                                       '((member (list-ref row-to-update (- col 1)) '(mud grass))
                                         (member (list-ref row-to-update (+ col 1)) '(mud grass)))))

      (display horizontal-spaces)
      (set! placed #t)
      )
    )
  )

(pretty-print-board board)
(fill-cell board 0 0 tent)
(define new-board (fill-cell board 0 0 tent))
(pretty-print-board new-board)
(fill-trees new-board n-trees)
