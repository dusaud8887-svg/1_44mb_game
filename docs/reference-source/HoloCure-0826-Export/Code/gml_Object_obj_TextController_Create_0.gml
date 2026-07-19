/*
DECOMPILER FAILED!

Underanalyzer.Decompiler.DecompilerException: Unexpected exception thrown in decompiler during AST cleanup: The method or operation is not implemented.
 ---> System.NotImplementedException: The method or operation is not implemented.
   at Underanalyzer.Decompiler.AST.StructNode.Underanalyzer.Decompiler.AST.IASTNode<Underanalyzer.Decompiler.AST.IStatementNode>.Clean(ASTCleaner cleaner)
   at Underanalyzer.Decompiler.AST.BlockNode.CleanAll(ASTCleaner cleaner)
   at Underanalyzer.Decompiler.AST.BlockNode.Underanalyzer.Decompiler.AST.IASTNode<Underanalyzer.Decompiler.AST.IStatementNode>.Clean(ASTCleaner cleaner)
   at Underanalyzer.Decompiler.DecompileContext.CleanupAST(IStatementNode ast)
   --- End of inner exception stack trace ---
   at Underanalyzer.Decompiler.DecompileContext.CleanupAST(IStatementNode ast)
   at Underanalyzer.Decompiler.DecompileContext.DecompileToAST()
   at Underanalyzer.Decompiler.DecompileContext.DecompileToString()
   at Submission#0.DumpCode(UndertaleCode code) in C:\Users\dusau\Downloads\HoloCure-0311\UTMT_CLI\ExportCode_HoloCure.csx:line 38
*/