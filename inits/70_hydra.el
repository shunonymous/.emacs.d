(use-package ivy-hydra
  :bind
  ("s-t" . hydra-editing/body)
  ("s-f" . hydra-frame-and-window/body)
  :init
  (defhydra hydra-editing (global-map "s-t")
    "Bind for editing"
    ("s" replace-string "string")
    ("r" replace-regexp "regexp")
    )
  (defhydra hydra-frame-and-window (global-map "s-f")
    "Control frame and window"
    ("<up>" windmove-up "up")
    ("<down>" windmove-down "down")
    ("<left>" windmove-left "left")
    ("<right>" windmove-right "right")
    ("<return>" other-frame "other frame")
    ("k" kill-current-buffer "kill")
    ("c" delete-window "close")
    ("f" delete-other-window "fullframe")
    ("v" split-window-vertically "split(vertical)")
    ("h" split-window-horizontally "split(horizonal)")
    ("o" make-frame "open other frame")
    )
  )
(use-package ivy-hydra
  :after (ivy hydra))
(use-package hydra-posframe
  :straight (hydra-posframe :type git :host github :repo "Ladicle/hydra-posframe")
  :hook (after-init . hydra-posframe-enable))
