(use ezxdisp)
(use numbers)

;; z(n+1) = z(n)^2 + C
(define f
	(lambda (n C)
		(if (> n 0)
			(+ (expt (f (- n 1) C) 2) C)
			0
		)
	)
)

;; maps mathematical space ([-1, 1]) to screen (0 to 400)
(define point
	(lambda (x)
		(* (+ x 1) 200)
	)
)

(define ezx (ezx-init 400 400 "Mandelbrot"))
(ezx-set-background ezx (make-ezx-color 0 0 0))
(define white (make-ezx-color 1 1 1))

(do ((x -1 (+ x 0.005))) ((> x 1))
	(do ((y -1 (+ y 0.005))) ((> y 1))
		(if (< (magnitude (f 25 (make-rectangular x y))) 2)
			(ezx-point-2d ezx (point x) (point y) white)
		)
	)
)

(print "done")
(ezx-redraw ezx)

(let loop ()
	(let-values (((b _ _) (ezx-pushbutton ezx)))
		(loop)
	)
)

(ezx-quit ezx)
