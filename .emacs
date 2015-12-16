;;load path
(add-to-list 'load-path "~/.emacs.d/lisp/")

(require 'epa-file)(epa-file-enable)

;;============Emacs 编辑环境设置 开始================
;;http://www.johndcook.com/blog/2012/03/07/shuffling-emacs-windows/
(require 'buffer-move)
(global-set-key (kbd "C-x C-<up>")     'buf-move-up)
(global-set-key (kbd "C-x C-<down>")   'buf-move-down)
(global-set-key (kbd "C-x C-<left>")   'buf-move-left)
(global-set-key (kbd "C-x C-<right>")  'buf-move-right)

;;使用内置 color theme
(load-theme 'misterioso)

;; use ibuffer to list buffers.
(defalias 'list-buffers 'ibuffer)

;;make ido-mode default for switching buffer(C-b x)
(ido-mode t)

;;启用cua模式
(cua-mode t)

;;stop backup files
(setq make-backup-files nil)

;;display current cursor position
(line-number-mode t)
(column-number-mode t)

;; wrap lines
(global-visual-line-mode t)

(global-linum-mode 0); 不显示列号，主要是为了照顾org文件。
(global-set-key (kbd "<f6>") 'global-linum-mode)

;;from http://ergoemacs.org/emacs/emacs_recentf.html
(recentf-mode 1) ; keep a list of recently opened files
;; set F7 to list recently opened file
(global-set-key (kbd "<f7>") 'recentf-open-files)

(show-paren-mode 1) ;当指针到一个括号时，自动显示所匹配的另一个括号

(tool-bar-mode 0);隐藏工具栏

(display-time-mode 1) ; 显示时间
(setq display-time-24hr-format t) ; 24小时格式
(setq display-time-day-and-date t) ; 显示日期

(setq frame-title-format "Jeffrey@%b") ; 在Title Bar上显示当前编辑的文档

(setq default-frame-alist '((height . 48) (width . 100) )) ;设置frame大小及位置

;;Here’s a function that you can use instead of kill-this-buffer, but which prevents some ;;buffers to be killed by mistake.You can modify that list, to fit your needs
;;this method is from http://www.emacswiki.org/emacs/KillingBuffers
(setq not-to-kill-buffer-list '("*scratch*" "*Messages*"))
(defun kill-buffer-but-not-some ()
  (interactive)
  (if (member (buffer-name (current-buffer)) not-to-kill-buffer-list)
      (bury-buffer)
    (kill-buffer (current-buffer))))
(global-set-key (kbd "C-x k") 'kill-buffer-but-not-some)  

;;编码设置
;;Setting default encoding system for saving a file
(setq coding-system-for-write 'utf-8)

;;============Emacs 编辑环境设置 结束================

;;==================Web Mode Start===============
;;web-mode http://web-mode.org/
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
;;==================Web Mode End=================

;;==================Java Setting Start=================
;;Java Editor configuration
;;bsd style is also known as Allman style after Eric Allman. Neither java style nor linux style is what I want.
(setq c-default-style "bsd"
      c-basic-offset 4
      tab-width 4
      indent-tabs-mode t)

;;java indent from http://www.emacswiki.org/emacs/IndentingJava
(add-hook 'java-mode-hook
	  (lambda ()
	    "Treat Java 1.5 @-style annotations as comments."
	    (setq c-comment-start-regexp "(@|/(/|[*][*]?))")
	    (modify-syntax-entry ?@ "< b" java-mode-syntax-table)))
;;==================Java Setting End=================

;;==================Org-mode Start=======================
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)

(require 'htmlize) ;htmlize.el
(setq org-src-fontify-natively t)
(setq org-fontify-emphasized-text nil)

;;done timestamp
(setq org-log-done t)

;;indent
(setq org-startup-indented t)

;;don't display emphasis markers, such as *, ~, =
(setq org-hide-emphasis-markers t)

;;agenda files
;;(setq org-agenda-files '("~/org"))
(setq org-agenda-files (list "~/org"
                             "~/org/programming" 
                             "~/org/english"))

;;workflow states
(setq org-todo-keywords
  '((sequence "TODO" "IN-PROGRESS" "WAITING" "PENDING" "DONE")))
;;tags
(setq org-tag-alist '(("@work" . ?w) ("@home" . ?h) ("@workORhome" . ?o) ("git" . ?g) ("web" . ?b) ("linux" . ?l) ("coding" . ?c) ("database" . ?d) ("emacs" . ?e) ("english" . ?y)))

;;capture settings
(setq org-capture-templates
      '(("p" "Projects" entry (file+headline "~/org/officetodo.org" "Projects")
         "* TODO %U : %?")
		("t" "Tasks" entry (file+headline "~/org/officetodo.org" "Tasks")
         "* TODO %U : %?")
		("s" "Self-improvement" entry (file+headline "~/org/officetodo.org" "Self-improvement")
         "* TODO %U : %?")
		("m" "Maybe" entry (file+headline "~/org/officetodo.org" "Maybe")
         "* %U : %?")
		("i" "Ideas" entry (file+headline "~/org/officetodo.org" "Ideas")
         "* %U : %?")
		("h" "Home ToDo" entry (file+headline "~/org/hometodo.org" "Tasks")
         "* TODO %U : %?")
        ("j" "Journal" entry (file+datetree "~/org/journal.org")
         "* %?\nEntered on %U")))

;;==================Org-mode End=======================

;;=================操作系统来设置 开始=====================
;;如果是Windows系统
(if (equal system-type 'windows-nt)
    (progn
      (message "Current system is 瘟都死")
      (server-start)

      ;;Setting English Font
      (set-face-attribute 'default nil :font " -outline-Consolas-normal-normal-normal-mono-14-*-*-*-c-*-iso8859-1")

      ;; Chinese Font
      (dolist (charset '(kana han symbol cjk-misc bopomofo))
		(set-fontset-font (frame-parameter nil 'font)
						  charset (font-spec :family "Microsoft Yahei"
											 :size 12)))))

;;如果是Cygwin系统
(if (equal system-type 'cygwin)
    (progn
      (message "Current system is Cygwin")
      ;;Setting English Font
      ;; (set-face-attribute 'default nil :font " -outline-Consolas-normal-normal-normal-mono-14-*-*-*-c-*-iso8859-1")
      (set-face-attribute 'default nil :font "Consolas 13")
      ;; Chinese Font
      (dolist (charset '(kana han symbol cjk-misc bopomofo))
	(set-fontset-font (frame-parameter nil 'font)
			  charset
			  (font-spec :family "Microsoft Yahei" :size 14)))

      ))

;;如果是linux系统
(if (or (eq system-type 'gnu/linux) (eq system-type 'linux))
    (progn
      (message "Current system is 来了可死")
     ;;(set-default-font "-unknown-DejaVu Sans Mono-normal-normal-normal-*-13-*-*-*-m-0-iso10646-1")
      ;;(set-fontset-font "fontset-default" 'unicode '("WenQuanYi Bitmap Song" . "unicode-bmp"))))
      (set-fontset-font "fontset-default" 'unicode '("WenQuanYi Zen Hei Mono" . "unicode-bmp"))))

;;如果是Apple系统
(if (eq system-type 'darwin)
    (progn
      (message "Current system is 苹果")
      (set-frame-font "Monaco:pixelsize=15")
      ;;(set-frame-font "Menlo-15")
      (dolist (charset '(han kana symbol cjk-misc bopomofo))
	(set-fontset-font (frame-parameter nil 'font)
			  charset
			  (font-spec :family "Hiragino Sans GB" :size 15)))))

;;=================操作系统来设置 结束=====================

;;============== My Key Bindings =================
(defun move-line-up ()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

(defun move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))

(global-set-key (kbd "C--") 'move-line-up)
(global-set-key (kbd "C-=") 'move-line-down)

;;Kill Line Backward
;;http://emacsredux.com/blog/2013/04/08/kill-line-backward/
(global-set-key (kbd "C-K") (lambda ()
			      (interactive)
			      (kill-line 0)))

