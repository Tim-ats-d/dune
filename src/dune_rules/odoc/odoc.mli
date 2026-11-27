(** Odoc rules *)

open Import

module Paths : sig
  val toplevel_index : Context.t -> Path.Build.t
end

val odoc_program : Super_context.t -> Path.Build.t -> Action.Prog.t Action_builder.t
val odoc_files_in_dirs : Path.t list -> _ Command.Args.t
val is_documentation_relevant : Lib.t -> bool Memo.t
val libs_of_pkg : Context_name.t -> pkg:Package.Name.t -> Lib.Local.t list Memo.t

(** The pages and the assets of the documentation of a package. *)
val mlds
  :  Super_context.t
  -> Dune_lang.Package_name.t
  -> (Doc_sources.mld list * Doc_sources.mld list) Memo.t

val run_odoc
  :  Super_context.t
  -> dir:Path.t
  -> string
  -> quiet:bool
  -> flags_for:Path.Build.t option
  -> Command.Args.any Command.Args.t list
  -> Action.Full.t Action_builder.With_targets.t

val setup_support_files_rule : Super_context.t -> dir:Path.Build.t -> unit Memo.t
val gen_project_rules : Super_context.t -> Dune_project.t -> unit Memo.t

val setup_private_library_doc_alias
  :  Super_context.t
  -> scope:Scope.t
  -> dir:Stdune.Path.Build.t
  -> Library.t
  -> unit Memo.t

val gen_rules
  :  Super_context.t
  -> dir:Path.Build.t
  -> string list
  -> Build_config.Gen_rules.t Memo.t
