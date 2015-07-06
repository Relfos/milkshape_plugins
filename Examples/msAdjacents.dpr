library msadjacents_Delphi;

uses
  SysUtils,
  Classes,
  Windows,
  MilkshapePlugin,
  TERRA_String,
  TERRA_Utils;

Type
  AdjacentsPlugin = Class(TMS3DPlugIn)
    Public
      Function GetType():Integer; Override;
      Function GetName():TERRAString; Override;
      Function Execute(pModel:PmsModel):Integer; Override;
    End;

{ AdjacentsPlugin }

Function AdjacentsPlugin.Execute(pModel: PmsModel): Integer;
Var
  Group:PmsMesh;
  VertexCount, GroupCount, FaceCount, I,J,K,N,O,R:Integer;
  Buf:Array Of Boolean;
  A,B:PmsTriangle;
  Found:Boolean;
  V1,V2:PmsVertex;
begin
  Found := False;
  GroupCount := msModel_GetMeshCount(pModel);
  For I:=0 To Pred(GroupCount) Do
  Begin
    Group := msModel_GetMeshAt(pModel, I);
    VertexCount := msMesh_GetVertexCount(Group);
    FaceCount := msMesh_GetTriangleCount(Group);
    For J:=0 To Pred(FaceCount) Do
    Begin
      A := msMesh_GetTriangleAt(Group, J);
      If A.nFlags And 1<>0 Then
      Begin
        Found := True;
        SetLength(Buf, VertexCount);
        For N:=0 To Pred(VertexCount) Do
          Buf[N] := False;


        For N:=0 To 2 Do
          Buf[A.nVertexIndices[N]] := True;

        V1 := msMesh_GetVertexAt(Group, A.nVertexIndices[0]);

        For R:=1 To 100 Do
          For K:=0 To Pred(FaceCount) Do
          If (K<>J) Then
          Begin
            B := msMesh_GetTriangleAt(Group, K);
            For N:=0 To 2 Do
            If (Buf[B.nVertexIndices[N]]) Then
            Begin
              For O:=0 To 2 Do
              Begin
                Buf[B.nVertexIndices[O]] := True;
                V2 := msMesh_GetVertexAt(Group, B.nVertexIndices[O]);
                msVertex_SetFlags(V2, V1.nFlags);
              End;

              msTriangle_SetFlags(B, A.nFlags);
            //MessageBox(0, PChar('Set flags:'+IntToString(A.nFlags))+' for '+IntToString(K)  , 'Plugin', MB_OK);
            Break;
            End;

          End;
        //Break;
      End;
    End;
  End;

  If Not Found Then
    MessageBox(0, 'Faces not selected!', 'Plugin', MB_OK);

  Result := 0;
End;

Function AdjacentsPlugin.GetName: TERRAString;
Begin
  Result := 'Select Adjacent';
End;

Function AdjacentsPlugin.GetType: Integer;
Begin
  Result := pluginTypeFace;
End;

Begin
  PluginClass := AdjacentsPlugin;
End.
