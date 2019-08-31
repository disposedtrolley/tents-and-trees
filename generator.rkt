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
(define mud (cell "💩" #t))

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

(define (tree-position-valid? board col row)
  (define row-to-update (list-ref board row))
  (cond
    [(cell-available? (list-ref row-to-update col))
     ;; @TODO maintain a list of adjacent cells rather than counts of horizontal and vertical free cells
     ;; should be a list of structs where each struct contains the cell type and direction. We can use
     ;; this representation to determine if a tree is part of a cluster to enforce special constraints
     (define horizontal-spaces
       (count identity
           (list (if (> col 0) (cell-available? (list-ref row-to-update (- col 1))) #f)
                 (if (< col (- board-size 1)) (cell-available? (list-ref row-to-update (+ col 1))) #f))))
     (define vertical-spaces
       (count identity
           (list (if (> row 0) (cell-available? (list-ref (list-ref board (- row 1)) col)) #f)
                 (if (< row (- board-size 1)) (cell-available? (list-ref (list-ref board (+ row 1)) col)) #f))))
     (displayln (format "C~aR~a HS: ~a VS: ~a" col row horizontal-spaces vertical-spaces))
     (or [> horizontal-spaces 0]
         [> vertical-spaces 0])]
    [else #f]))
  
(define (fill-trees-helper board selections)
  (cond
    [(= (length selections) n-trees) board] 
    [else
     (define col (random board-size))
     (define row (random board-size))

     (cond
       [(tree-position-valid? board col row)
        (set! board (fill-cell board col row tree))
        (set! selections (append selections (list (cons col row))))
        (displayln selections)]
       [else
        (set! selections (take selections (- (length selections) 1)))
        (set! board (fill-cell board col row mud))])
     (fill-trees-helper board selections)]))


;; Fills the board with n number of trees.
(define (fill-trees board)
  (fill-trees-helper board '()))


(pretty-print-board board)
(define filled-board (fill-trees board))
(pretty-print-board filled-board)
