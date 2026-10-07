(** Naming of libraries and packages in the generated documentation *)

open Import

module Scope_key : sig
  (** [of_string context s] finds the library named by [s], which is either a
      public library name or a private library unique name. *)
  val of_string : Context_name.t -> string -> (Lib_name.t * Lib.DB.t) Memo.t
end

(** Unique name of a local library: its name if it is public, or
    [name@key] where [key] identifies its project if it is private. *)
val lib_unique_name : Lib.t -> string

(** Where the documentation of a library goes: its package if it has one, or
    the library itself if it is private and has no package. *)
type t

val of_lib : Lib.t -> t

(** The package name, or [name@key] for a private library without a package,
    where [key] identifies its project. *)
val to_string : t -> string
