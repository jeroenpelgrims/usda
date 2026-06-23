(in-package #:pgloader.transforms)

(defun float-or-empty-to-null (value)
  "Handle SQLite real values: convert empty strings to NULL, floats to string."
  (cond
    ((null value) nil)
    ((stringp value)
     (if (string= value "")
         nil
         value))
    ((floatp value)
     (float-to-string value))
    (t value)))
