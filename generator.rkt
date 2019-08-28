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

;; Returns whether a cell is available. A cell is available if it can be filled with a tent.
(define (cell-available? cell)
  (contains (list (cell-display-char mud) (cell-display-char grass)) (cell-display-char cell)))

;; Fills the board with n number of trees.
(define (fill-trees board n)
  (cond
    [(= n 0) board]
    [else
      (define board-n (length board))
      (define placed #f)
      (while (not placed)
        ;; Continue to randomly choose a location for the tree until a valid cell is chosen.
        (define col (random board-n))
        (define row (random board-n))

        (define row-to-update (list-ref board row))

        ;; Verify the chosen cell is free to be filled with a tree.
        (cond
          [(cell-available? (list-ref row-to-update col))
           (define horizontal-spaces
             (count identity
                 (list (if (> col 0) (cell-available? (list-ref row-to-update (- col 1))) #f)
                       (if (< col (- board-n 1)) (cell-available? (list-ref row-to-update (+ col 1))) #f))))
           (define vertical-spaces
             (count identity
                 (list (if (> row 0) (cell-available? (list-ref (list-ref board (- row 1)) col)) #f)
                       (if (< row (- board-n 1)) (cell-available? (list-ref (list-ref board (+ row 1)) col)) #f))))
           (cond
             [(or (> horizontal-spaces 0)
                  (> vertical-spaces 0))
              (displayln (format "C~aR~a HS: ~a VS: ~a" col row horizontal-spaces vertical-spaces))
              (set! board (fill-cell board col row tree))
              (set! placed #t)])]))
      (fill-trees board (- n 1))]))



(pretty-print-board board)
(define filled-board (fill-trees board n-trees))
(pretty-print-board filled-board)
