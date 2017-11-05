(use ezxdisp)
(use numbers)

(define LEVELS 10)

;; return the n (0~max) where z(n) > 2
(define exceed
	(lambda (max C exponent)
		(let loop ((z 0) (n 0))
			(if (or (> (magnitude z) 2) (> n max))
				(- n 1)
				(loop (+ (expt z exponent) C) (+ n 1))
			)
		)
	)
)

;; maps mathematical space ([-1, 1]) to screen (0 to 400)
(define point
	(lambda (x)
		(* (+ x 1) 200)
	)
)

;; maps the number of iterations taken by z(n) to exceed 2 to a color
(define color
	(lambda (x)
		;; exact->inexact is required because the numbers library uses exact fractions
		(let ((c (exact->inexact (/ x LEVELS))))
			(make-ezx-color 0 c c)
		)
	)
)

(define ezx (ezx-init 400 400 "Animated Mandelbrot"))

(define draw
	(lambda (t)
		(ezx-wipe ezx)
		(do ((x -1 (+ x 0.005))) ((> x 1))
			(do ((y -1 (+ y 0.005))) ((> y 1))
				(ezx-point-2d ezx (point x) (point y) (color (exceed LEVELS (make-rectangular x y) t)))
			)
		)
		(ezx-redraw ezx)
	)
)

(do ((t 2 (+ t 0.2))) ((> t 4))
	(draw t)
	(print t)
)

(ezx-quit ezx)
