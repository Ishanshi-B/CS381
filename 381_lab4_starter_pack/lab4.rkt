#lang racket
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;     CS 381 - Programming Lab #4		;
;										                ;
;  Ishanshi Bhardwaj					    	;
;  bhardwai@oregonstate.edu	       	;
;										                ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Member? Function
(define (member? e lst)
  ; Determines if element `e` is in list `lst`
  (cond
    [(null? lst) #f]                    ; If the list is empty, return #f
    [(equal? e (car lst)) #t]           ; If the first element matches, return #t
    [else (member? e (cdr lst))]))      ; Otherwise, check the rest of the list

;; Set? Function
(define (set? lst)
  ; Checks if `lst` is a valid set (no duplicates)
  (cond
    [(null? lst) #t]                      ; An empty list is a set
    [(member? (car lst) (cdr lst)) #f]    ; If a duplicate is found, return #f
    [else (set? (cdr lst))]))             ; Recursively check the rest of the list

;; Union Function
(define (union lst1 lst2)
  ; Computes the union of `lst1` and `lst2`
  (cond
    [(null? lst1) lst2]                             ; If `lst1` is empty, return `lst2`
    [(member? (car lst1) lst2) (union (cdr lst1) lst2)] ; Skip duplicates from `lst1`
    [else (cons (car lst1) (union (cdr lst1) lst2))]))  ; Add unique elements to the result

;; Intersect Function
(define (intersect lst1 lst2)
  ; Computes the intersection of `lst1` and `lst2`
  (cond
    [(null? lst1) '()]                              ; If `lst1` is empty, return an empty list
    [(member? (car lst1) lst2)                      ; If `car lst1` is in `lst2`
     (cons (car lst1) (intersect (cdr lst1) lst2))] ; Include it in the result
    [else (intersect (cdr lst1) lst2)]))            ; Otherwise, skip it

;; Difference Function
(define (difference lst1 lst2)
  ; Computes `lst1 - lst2`
  (cond
    [(null? lst1) '()]                              ; If `lst1` is empty, return an empty list
    [(member? (car lst1) lst2)                      ; If `car lst1` is in `lst2`
     (difference (cdr lst1) lst2)]                  ; Skip it
    [else (cons (car lst1) (difference (cdr lst1) lst2))])) ; Otherwise, include it in the result

;; Flatten Function (Extra Credit)
(define (flatten lst1 lst2)
  ; Flattens `lst1` and `lst2`, removing nested lists
  (define (flatten-helper lst acc)
    (cond
      [(null? lst) acc]                             ; If `lst` is empty, return accumulated result
      [(pair? (car lst))                            ; If `car lst` is a nested list
       (flatten-helper (append (car lst) (cdr lst)) acc)] ; Flatten it
      [else (flatten-helper (cdr lst) (cons (car lst) acc))])) ; Otherwise, add it to the result
  (reverse (flatten-helper (append lst1 lst2) '()))) ; Reverse to maintain order


;;;;;;;;;;;;;;;;;
;  DO NOT EDIT  ;
;;;;;;;;;;;;;;;;;
; enables testing via piping in stdin
(define-namespace-anchor anc)
(define ns (namespace-anchor->namespace anc))
(let loop ()
  (define line (read-line (current-input-port) 'any))
  (if (eof-object? line)
    (display "")
    (begin (print (eval (read (open-input-string line)) ns)) (newline) (loop))))