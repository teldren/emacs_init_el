;; Hide startup
(setq inhibit-startup-message t)

;;Setting display time
(setq display-time-24hr-fomat t)
(setq display-time-fomat "%m/%d(%a) %R")
(setq display-time-day-and-date t)
(display-time)

;; global key bind
(global-set-key "\C-h" 'backward-delete-char)
(global-set-key "\M-g" 'goto-line)
(global-set-key "\C-\M-\\" 'indent-region)
(global-set-key "\C-z" 'undo)
(global-set-key "\C-\M-m" 'my-help)
(global-set-key "\C-x\C-x" 'suspend-frame)
(global-set-key (kbd "C-c t") 'toggle-truncate-lines)
(global-font-lock-mode t)
(if window-system
    (progn ;true
      (global-set-key "\C-x\C-c" 'server-edit)))

;; truncate line
(setq-default truncate-partial-width-windows t)
(setq-default truncate-lines t)

;; Typing any left bracket automatically insert the right matching bracket
(electric-pair-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Japanese Language
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(set-language-environment 'Japanese)
(let ((ws window-system))
  (cond ((eq ws 'w32)
         (prefer-coding-system 'utf-8-emacs-dos)
         (set-default-coding-systems 'utf-8-emacs-dos)
         (setq file-name-coding-system 'sjis)
         (setq locale-coding-system 'utf-8-emacs-dos))
        ((eq ws 'ns)
         (require 'ucs-normalize)
         (prefer-coding-system 'utf-8-hfs)
         (setq file-name-coding-system 'utf-8-hfs)
         (setq locale-coding-system 'utf-8-hfs))))
;; On Windows, Alphabet is Ricty Diminished、Japanse is Meiryo
;; On Mac, Font is menlokakugo
(let ((ws window-system))
  (cond ((eq ws 'w32)
         (set-face-attribute 'default nil
                             :family "Ricty Diminished"  ;; Alphabet
                             :height 100)
         (set-fontset-font nil 'japanese-jisx0208 (font-spec :family "Meiryo")))  ;; Japanese
        ((eq ws 'ns)
	 (setq default-input-method "MacOSX")
	 (mac-set-input-method-parameter "com.apple.inputmethod.Kotoeri.Japanese" `title\ "ことえり")
	 (progn (prefer-coding-system 'utf-8)
		(create-fontset-from-ascii-font "Menlo-14:weight=normal:slant=normal" nil "menlokakugo")
		(set-fontset-font "fontset-menlokakugo"
				  'unicode
				  (font-spec :family "Hiragino Kaku Gothic ProN" :size 14)
				  nil
				  'append)
		(add-to-list 'default-frame-alist '(font . "fontset-menlokakugo"))))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Window position, colour, size, etc.
(setq initial-frame-alist
      '((top . 1) (left . 20) (width . 210) (height . 55)))

;; Hide tool bar
(tool-bar-mode -1)
;; Hide menu bar
(menu-bar-mode -1)

;; Prevent line breaks
(setq next-line-add-newlines nil)

;; Show line number & column number
(line-number-mode t)
;(if window-system
;    (global-linum-mode t))
(global-linum-mode t)
(column-number-mode t)
(set-face-attribute 'linum nil
                    :foreground "#bf616a"
                    :height 0.9)
;; Format of line number
(setq linum-format "%4d ")

;; Prevent make backup files
(setq make-backup-files nil)

;; Highlight marked region
(transient-mark-mode 1)

;; Show file name on title bar
(setq frame-title-format (format "@%s : %%f" (system-name)))

;; Highlight the corresponding parenthesis
(show-paren-mode t)

;; Translucence of Window
(set-frame-parameter nil 'alpha 90)

;;Drag and drop
(define-key global-map [ns-drag-file] 'ns-find-file)
(setq ns-pop-up-frames nil)

;; Highlight space at the end of line
(setq-default show-trailing-whitespace t)
(set-face-background 'trailing-whitespace "#b14770")

;; full screen
(defun toggle-fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen (if (frame-parameter nil 'fullscreen)
					   nil
					 'fullboth)))

;; Show personal note
(defun my-help ()
  (interactive)
  (switch-to-buffer (find-file-noselect "~/.emacs.d/my-help.txt")))

;; Change tab to space
(setq-default indent-tabs-mode nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; run yatex mode when open .tex file
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(setq auto-mode-alist
;(cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
;(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)

;; yatex load path
;(setq load-path (cons (expand-file-name
;"/Applications/Emacs.app/Contents/Resources/site-lisp/yatex")
;load-path))

;; use utf-8 on yatex mode
;(setq YaTeX-kanji-code 4)

;(setq tex-command "ptex2pdf -u -l -ot \"-synctex=1\""
;      dvi2-command "open -a TeXShop"
;      bibtex-command "pbibtex")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; aspell
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq-default ispell-program-name "aspell")
(eval-after-load "ispell"
 '(add-to-list 'ispell-skip-region-alist '("[^\000-\377]+")))
(add-hook 'yatex-mode-hook 'flyspell-mode)
;(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
; '(custom-safe-themes (quote ("68d36308fc6e7395f7e6355f92c1dd9029c7a672cbecf8048e2933a053cf27e6" "11dd7fb48f2c0360f79e80a694c9e919a86dce32e5605018e9862e1e6287e3cb" default)))
; '(flyspell-auto-correct-binding [(control 58)])
; '(google-translate-default-source-language "ja")
; '(google-translate-default-target-language "en"))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; package.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Setting proxy
;; Execute the following command : (base64-encode-string "username:password")
;(setq url-proxy-services
;      '(("http" . "hostname:port")
;        ("https" . "hostname:port")))
;(setq url-http-proxy-basic-auth-storage
;        '(("hostname:port" ("Proxy" ."base64-encode-string"))))

(when (require 'package nil t)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
  (add-to-list 'package-archives '("ELPA" . "http://tromey.com/elpa/"))
  (package-initialize))

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(zenburn-theme
    material-theme
    async
    auto-complete
    exec-path-from-shell
;    google-translate
    helm
    highlight-symbol
    markdown-mode
    minimap
    popwin
    shell-switcher
    tabbar
    web-mode
;    jedi
;    virtualenvwrapper
;    auto-virtualenvwrapper
;    python-mode
    highlight-indentation
    flycheck
    flycheck-pos-tip
    helm-flycheck
    py-yapf
    js2-mode
    elpy
    company-quickhelp
    smartrep
    ))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Load theme (Zenburn)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(if window-system
;;  (progn ;true
;;    (load-theme 'zenburn t)
;;    (set-face-attribute 'highlight nil :foreground 'unspecified))
;;  (progn ;false
;;    (load-theme 'whiteboard t)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Load theme (Material-theme)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(if window-system
  (progn ;true
    (load-theme 'material t))
  (progn ;false
    (load-theme 'material-light t)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; web-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq auto-mode-alist
      (append '(
                ("\\.\\(html\\|xhtml\\|shtml\\|tpl\\|js\\|ejs\\)\\'" . web-mode)
                ("\\.php\\'" . php-mode)
                )
              auto-mode-alist))

(require 'web-mode)
(defun web-mode-hook ()
  "Hooks for Web mode."
  ;; web-modeの設定
  (setq web-mode-markup-indent-offset 2) ;; html indent
  (setq web-mode-css-indent-offset 2)    ;; css indent
  (setq web-mode-code-indent-offset 2)   ;; script indent(js,php,etc..)
)
(add-hook 'web-mode-hook  'web-mode-hook)
;; 色の設定
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(web-mode-comment-face ((t (:foreground "#D9333F"))))
 '(web-mode-css-at-rule-face ((t (:foreground "#FF7F00"))))
 '(web-mode-css-pseudo-class-face ((t (:foreground "#FF7F00"))))
 '(web-mode-css-rule-face ((t (:foreground "#A0D8EF"))))
 '(web-mode-doctype-face ((t (:foreground "#82AE46"))))
 '(web-mode-html-attr-name-face ((t (:foreground "#C97586"))))
 '(web-mode-html-attr-value-face ((t (:foreground "#82AE46"))))
 '(web-mode-html-tag-face ((t (:foreground "#E6B422" :weight bold))))
 '(web-mode-server-comment-face ((t (:foreground "#D9333F")))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; exec-path-from-shell(For mac or linux)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when (or (equal window-system 'ns) (equal window-system 'x))
  (exec-path-from-shell-initialize))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; pop win
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'popwin)
(setq helm-samewindow nil)
(setq display-buffer-function 'popwin:display-buffer)
;(setq display-buffer-alist 'popwin:display-buffer)
(setq popwin:popup-window-position 'bottom)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; google-translate
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(require 'google-translate)
;(global-set-key "\C-xt" 'google-translate-at-point)
;(global-set-key "\C-xT" 'google-translate-query-translate)
;; Default setting for translation is (ja -> en). C-u is disable
;; Using popwin
;(push '("*Google Translate*") popwin:special-display-config)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;auto-complete
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(require 'auto-complete-config)
(global-auto-complete-mode t)

(require 'auto-complete-config)
(ac-config-default)
(ac-set-trigger-key "TAB")
(setq ac-use-menu-map t) ;; Select candidates by C-n/C-p when completion menu is showed
(setq ac-use-fuzzy t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; helm
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'helm-config)
(helm-mode 1)
;; Delete by C-h
(define-key helm-map (kbd "C-h") 'delete-backward-char)
(define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)
;; For find-file etc.
(define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)
;; For helm-find-files etc.
(define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
;; key bind
(define-key global-map (kbd "C-x b")   'helm-buffers-list)
(define-key global-map (kbd "C-x C-b") 'helm-for-files)
(define-key global-map (kbd "C-x C-f") 'helm-find-files)
(define-key global-map (kbd "M-x")     'helm-M-x)
(define-key global-map (kbd "M-y")     'helm-show-kill-ring)
(define-key global-map (kbd "C-x C-r") 'helm-recentf)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; highlight-symbol
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'highlight-symbol)
;;; auto highlight
(add-hook 'prog-mode-hook 'highlight-symbol-mode)
;; hilight after 1 sec
;(setq highlight-symbol-idle-delay 1.0)
;(setq highlight-symbol-colors '("DarkOrange" "DodgerBlue1" "DeepPink1"))
;;; Move by M-p/M-n in source code mode
(add-hook 'prog-mode-hook 'highlight-symbol-nav-mode)
;;; Replace by symbol
(global-set-key (kbd "M-s M-r") 'highlight-symbol-query-replace)
(global-set-key [(control f3)] 'highlight-symbol-at-point)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; shell-switcher
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq shell-switcher-new-shell-function 'shell-switcher-make-shell)
(shell-switcher-mode 1)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; markdown
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq markdown-command "~/markdown")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; tabbar
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'tabbar)
(if window-system
    (progn ;true
      (tabbar-mode)))
(tabbar-mwheel-mode nil)                  ;; Disable mouse wheel
(setq tabbar-buffer-groups-function nil)  ;; Disable grouping
(setq tabbar-use-images nil)              ;; Disable images

;; Key bind
(global-set-key (kbd "<C-tab>") 'tabbar-forward-tab)
(global-set-key (kbd "<C-S-tab>") 'tabbar-backward-tab)

;; Hide left image
(dolist (btn '(tabbar-buffer-home-button
               tabbar-scroll-left-button
               tabbar-scroll-right-button))
  (set btn (cons (cons "" nil)
                 (cons "" nil))))

;; Length of separater
(setq tabbar-separator '(2.0))

;; Colour of tab
;; Change appearance
(set-face-attribute
 'tabbar-default nil
 :family "MeiryoKe_Gothic"
 :background "#34495E"
 :foreground "#EEEEEE"
 :height 0.95
 )
(set-face-attribute
 'tabbar-unselected nil
 :background "#34495E"
 :foreground "#EEEEEE"
 :box nil
)
(set-face-attribute
 'tabbar-modified nil
 :background "#E67E22"
 :foreground "#EEEEEE"
 :box nil
)
(set-face-attribute
 'tabbar-selected nil
 :background "#E74C3C"
 :foreground "#EEEEEE"
 :box nil)
(set-face-attribute
 'tabbar-button nil
 :box nil)
(set-face-attribute
 'tabbar-separator nil
 :height 1.5)

;; Setting of buffer to display on tab
(defvar my-tabbar-displayed-buffers
  '("*scratch*" "*Messages*" "*Backtrace*" "*Colors*" "*Faces*" "*vc-" "eshell" "Packages")
  "*Regexps matches buffer names always included tabs.")

(defun my-tabbar-buffer-list ()
  "Return the list of buffers to show in tabs.
Exclude buffers whose name starts with a space or an asterisk.
The current buffer and buffers matches `my-tabbar-displayed-buffers'
are always included."
  (let* ((hides (list ?\  ?\*))
         (re (regexp-opt my-tabbar-displayed-buffers))
         (cur-buf (current-buffer))
         (tabs (delq nil
                     (mapcar (lambda (buf)
                               (let ((name (buffer-name buf)))
                                 (when (or (string-match re name)
                                           (not (memq (aref name 0) hides)))
                                   buf)))
                             (buffer-list)))))
    ;; Always include the current buffer.
    (if (memq cur-buf tabs)
        tabs
      (cons cur-buf tabs))))
(setq tabbar-buffer-list-function 'my-tabbar-buffer-list)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ minimap
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'minimap)
(if window-system
    (progn ;true
      (minimap-mode t)))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(minimap-window-location (quote right))
 '(package-selected-packages
   (quote
    (company-quickhelp zenburn-theme web-mode tabbar smartrep shell-switcher py-yapf popwin minimap material-theme markdown-mode js2-mode highlight-symbol helm-flycheck helm elpy auto-complete))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; server start for emacs-client
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'server)
(unless (server-running-p)
  (server-start))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; jedi & virtualenvwrapper & auto-virtualenvwrapper
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(require 'epc)
;(require 'auto-complete-config)
;(require 'python-mode)
;(setq auto-mode-alist (cons '("\\.py\\'" . python-mode) auto-mode-alist))

;(require 'jedi)
;(add-hook 'python-mode-hook 'jedi:setup)
;(define-key jedi-mode-map (kbd "<C-tab>") nil) ;;C-tabはウィンドウの移動に用いる
;(setq jedi:complete-on-dot t)
;(setq jedi:tooltip-method 'popup)
;(setq ac-sources
;      (delete 'ac-source-words-in-same-mode-buffers ac-sources)) ;;jediの補完候補だけでいい
;(add-to-list 'ac-sources 'ac-source-filename)
;(add-to-list 'ac-sources 'ac-source-jedi-direct)
;(define-key python-mode-map "\C-ct" 'jedi:goto-definition)
;(define-key python-mode-map "\C-cb" 'jedi:goto-definition-pop-marker)
;(define-key python-mode-map "\C-cr" 'helm-jedi-related-names)

;(require 'virtualenvwrapper)
;(require 'auto-virtualenvwrapper)
;(add-hook 'python-mode-hook #'auto-virtualenvwrapper-activate)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Setting for python
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'python-mode-hook
          '(lambda ()
              (setq indent-tabs-mode nil);;tabの幅を変える
              (setq indent-level 4)
              (setq python-indent 4)
              (setq tab-width 4)
;              (define-key python-mode-map "\"" 'electric-pair) ;;括弧の補完
;              (define-key python-mode-map "\'" 'electric-pair)
;              (define-key python-mode-map "(" 'electric-pair)
;              (define-key python-mode-map "[" 'electric-pair)
;              (define-key python-mode-map "{" 'electric-pair)
;              (define-key company-active-map (kbd "\C-n") 'company-select-next)
;              (define-key company-active-map (kbd "\C-p") 'company-select-previous)
;              (define-key company-active-map (kbd "\C-d") 'company-show-doc-buffer)
;              (define-key company-active-map (kbd "<tab>") 'company-complete)
;              (auto-complete-mode -1)
              ))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Elpy (FYI: https://org-technology.com/posts/emacs-elpy.html)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(elpy-enable)
;; Setting of virtual env of Anaconda
;(defvar venv-default "~/.pyenv/versions/anaconda3-5.0.0")
;; Enable default env
;(pyvenv-activate venv-default)
;; Select Rope or Jedi for backend
(setq elpy-rpc-backend "jedi")
;;; Enable IPython for REPL
;;(elpy-use-ipython)

(require 'company)
(company-quickhelp-mode +1)
(setq company-selection-wrap-around t) ; go top if try to go to next at the bottom
(add-hook 'elpy-mode-hook
          '(lambda ()
;             (elpy-use-ipython)
             ;; Set C-cC-c as quickrun
             (define-key elpy-mode-map "\C-c\C-c" 'quickrun)
             ;; Disable autocompletion for company-mode + rope/jedi
             (auto-complete-mode -1)
             ; Set key map of company mode
             (define-key company-active-map (kbd "\C-n") 'company-select-next)
             (define-key company-active-map (kbd "\C-p") 'company-select-previous)
             (define-key company-active-map (kbd "\C-d") 'company-show-doc-buffer)
             (define-key company-active-map (kbd "<tab>") 'company-complete)
             (define-key company-active-map (kbd "C-h") nil)
             ))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; flycheck
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when (require 'flycheck nil t)
  (remove-hook 'elpy-modules 'elpy-module-flymake)
  (add-hook 'python-mode-hook 'flycheck-mode))
(with-eval-after-load 'flycheck
  (flycheck-pos-tip-mode))
(define-key elpy-mode-map (kbd "C-c C-v") 'helm-flycheck)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; smartrep
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'smartrep)
(smartrep-define-key elpy-mode-map "C-c"
  '(("C-n" . flycheck-next-error)
    ("C-p" . flycheck-previous-error)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; py-yapf(need to install yapf by using pip)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(add-hook 'python-mode-hook 'py-yapf-enable-on-save)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; highlight-indentation
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'highlight-indentation)
(add-hook 'python-mode-hook 'highlight-indentation-current-column-mode)
;(add-hook 'elpy-mode-hook 'highlight-indentation-current-column-mode)
;(set-face-background 'highlight-indentation-face "#313131")
;(set-face-background 'highlight-indentation-current-column-face "#777777")
;(add-hook 'python-mode-hook 'highlight-indentation-mode)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; js2-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'after-init-hook #'global-flycheck-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

