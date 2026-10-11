#' The nine layers of the determinant stack
#'
#' Returns the layer names, in order from the hardware at the base to
#' intrinsic non-determinism at the top, and the rung that secures
#' each one across the book as a whole, per the levels chapter.
#' Every chapter
#' that draws the stack diagram starts from this single mapping, so
#' the ambient coloring cannot drift between chapters even as each
#' chapter highlights a different subset.
#'
#' @return A tibble with columns `layer`, `height` (plotting order,
#'   1 at the base), and `secures` (the rung that first pins the
#'   layer across the book, or `'Unpinned by any rung'`).
#' @export
determinant_layers <- function() {
  tibble::tibble(
    layer = c('Hardware',
              'Numerical libraries (BLAS, LAPACK)',
              'Operating system, system libraries',
              'R runtime',
              'Package versions',
              'Session configuration',
              'Analysis code',
              'Input data',
              'Intrinsic non-determinism'),
    height = 1:9,
    secures = c('Unpinned by any rung',
                'Unpinned by any rung',
                'L2 pinned environment',
                'L2 pinned environment',
                'L1 pinned packages',
                'L2 partially pinned',
                'L0 locatable',
                'L0 locatable',
                'Unpinned by any rung')
  )
}

#' Plot the determinant stack, with this chapter's layers highlighted
#'
#' Draws the nine-layer determinant stack every chapter shares
#' (`determinant_layers()`), filled by the rung that secures each
#' layer across the book, with the layers this chapter *captures* or
#' *validates* picked out from the rest. A layer this chapter
#' captures is one it pins for the first time or pins more tightly;
#' a layer it validates is one it checks without itself pinning
#' anything new, the capture-versus-validation distinction the
#' levels chapter draws. Every other chapter's stack diagram is a
#' call
#' to this one function, so the figure cannot describe a layer the
#' alt text does not, or the reverse: [determinant_stack_alt()]
#' builds its sentence from the same `captures` and `validates`
#' arguments passed here.
#'
#' @param captures Character vector of layer names (from
#'   `determinant_layers()$layer`) this chapter captures. Drawn with
#'   a solid fill in the color of the rung it secures.
#' @param validates Character vector of layer names this chapter
#'   validates without capturing. Drawn with a hatched border in the
#'   same rung color, over the ambient fill. A layer may appear in
#'   both.
#' @param title Plot title. Defaults to a generic caption; pass one
#'   that names the chapter if the figure needs to say more.
#' @return A ggplot object.
#' @importFrom ggplot2 .data
#' @export
plot_determinant_stack <- function(captures = character(0),
                                   validates = character(0),
                                   title = 'Where this chapter sits on the stack') {
  layers <- determinant_layers()
  bad <- setdiff(c(captures, validates), layers$layer)
  if (length(bad)) {
    stop('Not a determinant layer: ', paste(bad, collapse = ', '),
         call. = FALSE)
  }

  layers$secures <- factor(
    layers$secures,
    levels = c('L0 locatable', 'L1 pinned packages',
               'L2 pinned environment', 'L2 partially pinned',
               'Unpinned by any rung'))
  layers$role <- ifelse(
    layers$layer %in% intersect(captures, validates), 'Captured and validated',
    ifelse(layers$layer %in% captures, 'Captured here',
           ifelse(layers$layer %in% validates, 'Validated here',
                  'Elsewhere in the book')))
  layers$role <- factor(
    layers$role,
    levels = c('Captured here', 'Validated here',
               'Captured and validated', 'Elsewhere in the book'))
  layers$alpha <- ifelse(layers$role == 'Elsewhere in the book', 0.35, 1)
  layers$linewidth <- ifelse(layers$role %in%
                               c('Validated here', 'Captured and validated'),
                             1.1, 0)

  rung_colors <- c('L0 locatable' = '#6baed6',
                    'L1 pinned packages' = '#3182bd',
                    'L2 pinned environment' = '#08519c',
                    'L2 partially pinned' = '#fd8d3c',
                    'Unpinned by any rung' = '#737373')

  ggplot2::ggplot(layers, ggplot2::aes(
      x = stats::reorder(.data$layer, .data$height),
      y = 1, fill = .data$secures, alpha = .data$alpha)) +
    ggplot2::geom_col(width = 0.9,
      ggplot2::aes(linewidth = .data$linewidth),
      colour = 'black') +
    ggplot2::coord_flip() +
    ggplot2::scale_fill_manual(values = rung_colors, name = 'Rung') +
    ggplot2::scale_alpha_identity() +
    ggplot2::scale_linewidth_identity() +
    ggplot2::labs(x = NULL, y = NULL, title = title) +
    ggplot2::theme_minimal(base_size = 11) +
    ggplot2::theme(axis.text.x = ggplot2::element_blank(),
                  panel.grid = ggplot2::element_blank(),
                  legend.position = 'bottom')
}

#' Generate alt text for [plot_determinant_stack()]
#'
#' Builds the figure's alt text from the same `captures` and
#' `validates` arguments the figure itself was drawn with, so the
#' description cannot say more, or less, than the picture shows.
#'
#' @inheritParams plot_determinant_stack
#' @return A single character string.
#' @export
determinant_stack_alt <- function(captures = character(0),
                                  validates = character(0)) {
  layers <- determinant_layers()
  both <- intersect(captures, validates)
  cap_only <- setdiff(captures, both)
  val_only <- setdiff(validates, both)

  describe <- function(x) {
    if (!length(x)) return(NULL)
    paste(x, collapse = ', ')
  }

  parts <- c(
    if (length(cap_only))
      paste0('captures ', describe(cap_only)),
    if (length(val_only))
      paste0('validates ', describe(val_only)),
    if (length(both))
      paste0('both captures and validates ', describe(both))
  )

  n_remaining <- nrow(layers) - length(union(captures, validates))
  remainder <- if (n_remaining == 0) {
    'Every layer is highlighted, so none is shown faded.'
  } else {
    sprintf(paste0('The remaining %d layer%s shown faded, for ',
                   'context, as secured elsewhere in the book.'),
            n_remaining, if (n_remaining == 1) ' is' else 's are')
  }

  sprintf(
    paste0('A horizontal bar chart of the nine-layer determinant ',
           'stack, hardware at the bottom and intrinsic ',
           'non-determinism at the top, each bar colored by the ',
           'rung that secures it across the book. This chapter %s; ',
           'those layers are drawn at full color and, where ',
           'validated, with a bordered outline. %s'),
    paste(parts, collapse = '; '),
    remainder
  )
}
