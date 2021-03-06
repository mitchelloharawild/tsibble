# nocov start
.onLoad <- function(...) {
  register_s3_method("pillar", "pillar_shaft", "yearweek")
  register_s3_method("pillar", "pillar_shaft", "yearmonth")
  register_s3_method("pillar", "pillar_shaft", "yearquarter")

  register_s3_method("pillar", "is_vector_s3", "yearweek")
  register_s3_method("pillar", "is_vector_s3", "yearmonth")
  register_s3_method("pillar", "is_vector_s3", "yearquarter")

  register_s3_method("pillar", "obj_sum", "yearweek")
  register_s3_method("pillar", "obj_sum", "yearmonth")
  register_s3_method("pillar", "obj_sum", "yearquarter")

  invisible()
}

register_s3_method <- function(pkg, generic, class, fun = NULL) {
  stopifnot(is.character(pkg), length(pkg) == 1)
  stopifnot(is.character(generic), length(generic) == 1)
  stopifnot(is.character(class), length(class) == 1)

  if (is_null(fun)) {
    fun <- get(paste0(generic, ".", class), envir = parent.frame())
  } else {
    stopifnot(is.function(fun))
  }

  if (pkg %in% loadedNamespaces()) {
    registerS3method(generic, class, fun, envir = asNamespace(pkg))
  }

  # Always register hook in case package is later unloaded & reloaded
  setHook(
    packageEvent(pkg, "onLoad"),
    function(...) {
      registerS3method(generic, class, fun, envir = asNamespace(pkg))
    }
  )
}
# nocov end
