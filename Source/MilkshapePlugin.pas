Unit MilkshapePlugin;


Interface
Uses TERRA_String, TERRA_Vector2D, TERRA_Vector3D, TERRA_Vector4D;

//Constants
Const
    MS3D_DLL = 'msModelLib.dll';
    MS_MAX_NAME = 32;
    MS_MAX_PATH = 256;

Const
      msSelected = 1;
      msSelected2 = 2;
      msHidden = 4;
      msDirty = 8;
      msAveraged = 16;
      msKeepVertex = 32;
      msSphereMap = $80;
      msHasAlpha = $40;

Type
  PIndexArray = ^IndexArray;
  IndexArray = Array[0..64000] Of Word;

//MS3DVertex
    PmsVertex = ^MS3DVertex;
    MS3DVertex = record
        nFlags: byte;
        Vertex: Vector3D;
        u, v: single;
        nBoneIndex: Shortint;
    end;

//MS3DVertexEx
    PmsVertexEx = ^MS3DVertexEx;
    MS3DVertexEx = record
        nBoneIndices: array[0..2] of shortint;
        nBoneWeights: array[0..2] of byte;
    end;

//TmsTriangle
    PmsTriangle = ^TmsTriangle;
    TmsTriangle = record
        nFlags: word;
        nVertexIndices: array[0..2] of word;
        nNormalIndices: array[0..2] of word;
        Normal: Vector3D;
        nSmoothingGroup: byte;
    end;

//TmsTriangleEx
    PmsTriangleEx = ^TmsTriangleEx;
    TmsTriangleEx = record
        Normals: array[0..2] of Vector3D;
        TexCoords: array[0..2] of Vector2D;
    end;

//TmsMesh
    PmsMesh = ^TmsMesh;
    TmsMesh = record
        nFlags: byte;
        szName: array[0..MS_MAX_NAME-1] of char;
        nNumTriangles:Word;
        pTriangles: PmsTriangle;
        nMaterialIndex:SmallInt;

        {nMaterialIndex: smallint;

        nNumVertices: word;
        nNumAllocedVertices: word;
        pVertices: PmsVertex;

        nNumNormals: word;
        nNumAllocedNormals: word;
        pNormals: PmsVec3;

        nNumTriangles: word;
        nNumAllocedTriangles: word;
        pTriangles: PmsTriangle;

        pszComment: pchar;
        pVertexExs: PmsVertexEx;
        pTriangleExs: PmsTriangleEx;}
    end;

//TmsMaterial
    PmsMaterial = ^TmsMaterial;
    TmsMaterial = record
        nFlags: integer;
        szName: array[0..MS_MAX_NAME-1] of char;
        Ambient: Vector4D;
        Diffuse: Vector4D;
        Specular: Vector4D;
        Emissive: Vector4D;
        fShininess: single;
        fTransparency: single;
        szDiffuseTexture: array[0..MS_MAX_PATH-1] of char;
        szAlphaTexture: array[0..MS_MAX_PATH-1] of char;
        nName: integer;
        pszComment: pchar;
    end;

//TmsPositionKey
    PmsPositionKey = ^TmsPositionKey;
    TmsPositionKey = record
        fTime: single;
        Position: Vector3D;
    end;

//TmsRotationKey
    PmsRotationKey = ^TmsRotationKey;
    TmsRotationKey = record
        fTime: single;
        Rotation: Vector3D;
    end;

//TmsBone
    PmsBone = ^TmsBone;
    TmsBone = record
        nFlags: integer;
        szName: array[0..MS_MAX_NAME-1] of char;
        szParentName: array[0..MS_MAX_NAME-1] of char;
        PositionTmsVec3: Vector3D;
        RotationTmsVec3: Vector3D;

        nNumPositionKeys: integer;
        nNumAllocedPositionKeys: integer;
        pPositionKeys: PmsPositionKey;

        nNumRotationKeys: integer;
        nNumAllocedRotationKeys: integer;
        pRotationKeys: PmsRotationKey;
        pszComment: pchar;
    end;

//TmsModel
    PmsModel = ^TmsModel;
    TmsModel = record
        nNumMeshes: integer;
        nNumAllocedMeshes: integer;
        pMeshes: PmsMesh;

        nNumMaterials: integer;
        nNumAllocedMaterials: integer;
        pMaterials: PmsMaterial;

        nNumBones: integer;
        nNumAllocedBones: integer;
        pBones: PmsBone;

        nFrame: integer;
        nTotalFrames: integer;

        Position: Vector3D;
        Rotation: Vector3D;

        CameraPosition: Vector3D;
        CameraRotationXY: Vector2D;

        pszComment: pchar;
    end;

//MilkShape 3D Interface

//msModel
procedure msModel_Destroy(pModel: Pmsmodel); cdecl; external MS3D_DLL;
function msModel_GetMeshCount(pModel: PmsModel): integer; cdecl; external MS3D_DLL;
function msModel_AddMesh(pModel: Pmsmodel): integer; cdecl; external MS3D_DLL;
function msModel_GetMeshAt(pModel: Pmsmodel; nIndex: integer): PmsMesh; cdecl; external MS3D_DLL;
function msModel_FindMeshByName(pModel: Pmsmodel; const szName: pchar): integer; cdecl; external MS3D_DLL;
function msModel_GetMaterialCount(pModel: Pmsmodel): integer; cdecl; external MS3D_DLL;
function msModel_AddMaterial(pModel: Pmsmodel): integer; cdecl; external MS3D_DLL;
function msModel_GetMaterialAt(pModel: Pmsmodel; nIndex: integer): PmsMaterial; cdecl; external MS3D_DLL;
function msModel_FindMaterialByName(pModel: Pmsmodel; const szName: pchar): integer; cdecl; external MS3D_DLL;
function msModel_GetBoneCount(pModel: Pmsmodel): integer; cdecl; external MS3D_DLL;
function msModel_AddBone(pModel: Pmsmodel): integer; cdecl; external MS3D_DLL;
function msModel_GetBoneAt(pModel: Pmsmodel; nIndex: integer): PmsBone; cdecl; external MS3D_DLL;
function msModel_FindBoneByName(pModel: Pmsmodel; szName: pchar): integer; cdecl; external MS3D_DLL;
function msModel_SetFrame(pModel: Pmsmodel; nFrame: integer): integer; cdecl; external MS3D_DLL;
function msModel_GetFrame(pModel: Pmsmodel): integer; cdecl; external MS3D_DLL;
function msModel_SetTotalFrames(pModel: Pmsmodel; nTotalFrames: integer): integer; cdecl; external MS3D_DLL;
function msModel_GetTotalFrames(pModel: Pmsmodel): integer; cdecl; external MS3D_DLL;
procedure msModel_SetPosition(pModel: Pmsmodel; Rotation: Vector3D); cdecl; external MS3D_DLL;
procedure msModel_GetPosition(pModel: Pmsmodel; Position: Vector3D); cdecl; external MS3D_DLL;
procedure msModel_SetRotation(pModel: Pmsmodel; Rotation: Vector3D); cdecl; external MS3D_DLL;
procedure msModel_GetRotation(pModel: Pmsmodel; Rotation: Vector3D); cdecl; external MS3D_DLL;
procedure msModel_SetCamera(pModel: Pmsmodel; Position: Vector3D; RotationXY: Vector2D); cdecl; external MS3D_DLL;
procedure msModel_GetCamera(pModel: Pmsmodel; Position: Vector3D; RotationXY: Vector2D); cdecl; external MS3D_DLL;
procedure msModel_SetComment(pModel: Pmsmodel; pszComment: pchar); cdecl; external MS3D_DLL;
function msModel_GetComment(pModel: Pmsmodel; pszComment: pchar; nMaxCommentLength: integer): integer; cdecl; external MS3D_DLL;

//msMesh
procedure msMesh_Destroy(pMesh: PmsMesh); cdecl; external MS3D_DLL;
procedure msMesh_SetFlags(pMesh: PmsMesh; nFlags: byte); cdecl; external MS3D_DLL;
function msMesh_GetFlags(pMesh: PmsMesh): byte; cdecl; external MS3D_DLL;
procedure msMesh_SetName(pMesh: PmsMesh; const szName: pchar); cdecl; external MS3D_DLL;
procedure msMesh_GetName(pMesh: PmsMesh; szName: pchar; nMaxLength: integer); cdecl; external MS3D_DLL;
procedure msMesh_SetMaterialIndex(pMesh: PmsMesh; nIndex: integer); cdecl; external MS3D_DLL;
function msMesh_GetMaterialIndex(pMesh: PmsMesh): integer; cdecl; external MS3D_DLL;
function msMesh_GetVertexCount(pMesh: PmsMesh): integer; cdecl; external MS3D_DLL;
function msMesh_AddVertex(pMesh: PmsMesh): integer; cdecl; external MS3D_DLL;
function msMesh_GetVertexAt(pMesh: PmsMesh; nIndex: integer): PmsVertex; cdecl; external MS3D_DLL;
function msMesh_GetVertexExAt(pMesh: PmsMesh; nIndex: integer): PmsVertexEx; cdecl; external MS3D_DLL;
function msMesh_GetInterpolatedVertexAt(pMesh: PmsMesh; nIndex: integer): PmsVertex; cdecl; external MS3D_DLL; // NOT YET IMPLEMENTED
function msMesh_GetTriangleCount(pMesh: PmsMesh): integer; cdecl; external MS3D_DLL;
function msMesh_AddTriangle(pMesh: PmsMesh): integer; cdecl; external MS3D_DLL;
function msMesh_GetTriangleAt(pMesh: PmsMesh; nIndex: integer): PmsTriangle; cdecl; external MS3D_DLL;
function msMesh_GetTriangleExAt(pMesh: PmsMesh; nIndex: integer): PmsTriangleEx; cdecl; external MS3D_DLL;
function msMesh_GetVertexNormalCount(pMesh: PmsMesh): integer; cdecl; external MS3D_DLL;
function msMesh_AddVertexNormal(pMesh: PmsMesh): integer; cdecl; external MS3D_DLL;
procedure msMesh_SetVertexNormalAt(pMesh: PmsMesh; nIndex: integer; Normal: Vector3D); cdecl; external MS3D_DLL;
procedure msMesh_GetVertexNormalAt(pMesh: PmsMesh; nIndex: integer; Normal: Vector3D); cdecl; external MS3D_DLL;
procedure msMesh_GetInterpolatedVertexNormalAt(pMesh: PmsMesh; nIndex: integer; Normal: Vector3D); cdecl; external MS3D_DLL; // NOT YET IMPLEMENTED
procedure msMesh_SetComment(pMesh: PmsMesh; const pszComment: pchar); cdecl; external MS3D_DLL;
function msMesh_GetComment(pMesh: PmsMesh; pszComment: pchar; nMaxCommentLength: integer): integer; cdecl; external MS3D_DLL;

//msTriangle
procedure msTriangle_SetFlags(pTriangle: PmsTriangle; nFlags: word); cdecl; external MS3D_DLL;
function msTriangle_GetFlags(pTriangle: PmsTriangle): word; cdecl; external MS3D_DLL;
procedure msTriangle_SetVertexIndices(pTriangle: PmsTriangle; nIndices: PIndexArray); cdecl; external MS3D_DLL;
procedure msTriangle_GetVertexIndices(pTriangle: PmsTriangle; nIndices: PIndexArray); cdecl; external MS3D_DLL;
procedure msTriangle_SetNormalIndices(pTriangle: PmsTriangle; nNormalIndices: PIndexArray); cdecl; external MS3D_DLL;
procedure msTriangle_GetNormalIndices(pTriangle: PmsTriangle; nNormalIndices: PIndexArray); cdecl; external MS3D_DLL;
procedure msTriangle_SetSmoothingGroup(pTriangle: PmsTriangle; nSmoothingGroup: byte); cdecl; external MS3D_DLL;
function msTriangle_GetSmoothingGroup(pTriangle: PmsTriangle): byte; cdecl; external MS3D_DLL;

//msTriangleEx
procedure msTriangleEx_SetNormal(pTriangle: PmsTriangleEx; nIndex: integer; Normal: Vector3D); cdecl; external MS3D_DLL;
procedure msTriangleEx_GetNormal(pTriangle: PmsTriangleEx; nIndex: integer; Normal: Vector3D); cdecl; external MS3D_DLL;
procedure msTriangleEx_SetTexCoord(pTriangle: PmsTriangleEx; nIndex: integer; TexCoord: Vector2D); cdecl; external MS3D_DLL;
procedure msTriangleEx_GetTexCoord(pTriangle: PmsTriangleEx; nIndex: integer; TexCoord: Vector2D); cdecl; external MS3D_DLL;

//msVertex
procedure msVertex_SetFlags(pVertex: PmsVertex; nFlags: byte); cdecl; external MS3D_DLL;
function msVertex_GetFlags(pVertex: PmsVertex): byte; cdecl; external MS3D_DLL;
procedure msVertex_SetVertex(pVertex: PmsVertex; Vertex: Vector3D); cdecl; external MS3D_DLL;
procedure msVertex_GetVertex(pVertex: PmsVertex; Vertex: Vector3D); cdecl; external MS3D_DLL;
procedure msVertex_SetTexCoords(pVertex: PmsVertex; st: Vector2D); cdecl; external MS3D_DLL;
procedure msVertex_GetTexCoords(pVertex: PmsVertex; st: Vector2D); cdecl; external MS3D_DLL;
function msVertex_SetBoneIndex(pVertex: PmsVertex; nBoneIndex: integer): integer; cdecl; external MS3D_DLL;
function msVertex_GetBoneIndex(pVertex: PmsVertex): integer; cdecl; external MS3D_DLL;

//msVertexEx
function msVertexEx_SetBoneIndices(pVertex: PmsVertexEx; nIndex: integer; nBoneIndex: integer): integer; cdecl; external MS3D_DLL;
function msVertexEx_GetBoneIndices(pVertex: PmsVertexEx; nIndex: integer): integer; cdecl; external MS3D_DLL;
function msVertexEx_SetBoneWeights(pVertex: PmsVertexEx; nIndex: integer; nWeight: integer): integer; cdecl; external MS3D_DLL;
function msVertexEx_GetBoneWeights(pVertex: PmsVertexEx; nIndex: integer): integer; cdecl; external MS3D_DLL;

//msMaterial
procedure msMaterial_SetFlags(pMaterial: PmsMaterial; nFlags: integer);cdecl; external MS3D_DLL;
function msMaterial_GetFlags(pMaterial: PmsMaterial): integer;  cdecl; external MS3D_DLL;
procedure msMaterial_SetName(pMaterial: PmsMaterial; const szName: pchar);cdecl; external MS3D_DLL;
procedure msMaterial_GetName(pMaterial: PmsMaterial; szName: pchar; nMaxLength: integer);   cdecl; external MS3D_DLL;
procedure msMaterial_SetAmbient(pMaterial: PmsMaterial; Ambient: Vector4D);  cdecl; external MS3D_DLL;
procedure msMaterial_GetAmbient(pMaterial: PmsMaterial; Ambient: Vector4D); cdecl; external MS3D_DLL;
procedure msMaterial_SetDiffuse(pMaterial: PmsMaterial; Diffuse: Vector4D); cdecl; external MS3D_DLL;
procedure msMaterial_GetDiffuse(pMaterial: PmsMaterial; Diffuse: Vector4D); cdecl; external MS3D_DLL;
procedure msMaterial_SetSpecular(pMaterial: PmsMaterial; Specular: Vector4D);cdecl; external MS3D_DLL;
procedure msMaterial_GetSpecular(pMaterial: PmsMaterial; Specular: Vector4D); cdecl; external MS3D_DLL;
procedure msMaterial_SetEmissive(pMaterial: PmsMaterial; Emissive: Vector4D); cdecl; external MS3D_DLL;
procedure msMaterial_GetEmissive(pMaterial: PmsMaterial; Emissive: Vector4D); cdecl; external MS3D_DLL;
procedure msMaterial_SetShininess(pMaterial: PmsMaterial; fShininess: single);  cdecl; external MS3D_DLL;
function msMaterial_GetShininess(pMaterial: PmsMaterial): single; cdecl; external MS3D_DLL;
procedure msMaterial_SetTransparency(pMaterial: PmsMaterial; fTransparency: single); cdecl; external MS3D_DLL;
function msMaterial_GetTransparency(pMaterial: PmsMaterial): single;   cdecl; external MS3D_DLL;
procedure msMaterial_SetDiffuseTexture(pMaterial: PmsMaterial; const szDiffuseTexture: pchar);  cdecl; external MS3D_DLL;
procedure msMaterial_GetDiffuseTexture(pMaterial: PmsMaterial; szDiffuseTexture: pchar; nMaxLength: integer);cdecl; external MS3D_DLL;
procedure msMaterial_SetAlphaTexture(pMaterial: PmsMaterial; const szAlphaTexture: pchar); cdecl; external MS3D_DLL;
procedure msMaterial_GetAlphaTexture(pMaterial: PmsMaterial; szAlphaTexture: pchar; nMaxLength: integer);  cdecl; external MS3D_DLL;
procedure msMaterial_SetComment(pMaterial: PmsMaterial; const pszComment: pchar);                     cdecl; external MS3D_DLL;
function msMaterial_GetComment(pMaterial: PmsMaterial; pszComment: pchar; nMaxCommentLength: integer): integer;  cdecl; external MS3D_DLL;

//msBone
procedure msBone_Destroy(pBone: PmsBone);  cdecl; external MS3D_DLL;
procedure msBone_SetFlags(pBone: PmsBone; nFlags: integer);  cdecl; external MS3D_DLL;
function msBone_GetFlags(pBone: PmsBone): integer;  cdecl; external MS3D_DLL;
procedure msBone_SetName(pBone: PmsBone; const szName: pchar); cdecl; external MS3D_DLL;
procedure msBone_GetName(pBone: PmsBone; szName: pchar; nMaxLength: integer);cdecl; external MS3D_DLL;
procedure msBone_SetParentName(pBone: PmsBone; const szParentName: pchar);   cdecl; external MS3D_DLL;
procedure msBone_GetParentName(pBone: PmsBone; szParentName: pchar; nMaxLength: integer); cdecl; external MS3D_DLL;
procedure msBone_SetPosition(pBone: PmsBone; Position: Vector3D);    cdecl; external MS3D_DLL;
procedure msBone_GetPosition(pBone: PmsBone; Position: Vector3D);   cdecl; external MS3D_DLL;
procedure msBone_GetInterpolatedPosition(pBone: PmsBone; Position: Vector3D);cdecl; external MS3D_DLL; // NOT YET IMPLEMENTED
procedure msBone_SetRotation(pBone: PmsBone; Rotation: Vector3D);cdecl; external MS3D_DLL;
procedure msBone_GetRotation(pBone: PmsBone; Rotation: Vector3D); cdecl; external MS3D_DLL;
procedure msBone_GetInterpolatedRotation(pBone: PmsBone; Rotation: Vector3D); cdecl; external MS3D_DLL;// NOT YET IMPLEMENTED

function msBone_GetPositionKeyCount(pBone: PmsBone): integer; cdecl; external MS3D_DLL;
function msBone_AddPositionKey(pBone: PmsBone; fTime: single; Position: Vector3D): integer; cdecl; external MS3D_DLL;
function msBone_GetPositionKeyAt(pBone: PmsBone; nIndex: integer): PmsPositionKey; cdecl; external MS3D_DLL;

function msBone_GetRotationKeyCount(pBone: PmsBone): integer;cdecl; external MS3D_DLL;
function msBone_AddRotationKey(pBone: PmsBone; fTime: single; Rotation: Vector3D): integer;  cdecl; external MS3D_DLL;
function msBone_GetRotationKeyAt(pBone: PmsBone; nIndex: integer): PmsRotationKey;cdecl; external MS3D_DLL;
procedure msBone_SetComment(pBone: PmsBone; const pszComment: pchar);cdecl; external MS3D_DLL;
function msBone_GetComment(pBone: PmsBone; pszComment: pchar; nMaxCommentLength: integer): integer; cdecl; external MS3D_DLL;

Const
  // plugin types
  pluginTypeImport  = 1;
  pluginTypeExport  = 2;
  pluginTypeTool    = 3;
  pluginTypeEdit    = 4;
  pluginTypeVertex  = 5;
  pluginTypeFace    = 6;
  pluginTypeAnimate = 7;
  pluginTypeMask    = $000F;
  pluginNormalsAndTexCoordsPerTriangleVertex = 128;

Type
  TMS3DPlugIn = Class
    Public
      Function GetType():Integer; Virtual; Abstract;
      Function GetName():TERRAString; Virtual; Abstract;
      Function Execute(Model:PmsModel):Integer; Virtual; Abstract;
    End;

  TMS3DPluginClass = Class Of TMS3DPlugIn;

Var
  PluginClass:TMS3DPluginClass = Nil;

Implementation

Type
  PPluginVMT = ^PluginVMT;
  PluginVMT = Record
    Destroy,
    GetType,
    GetTitle,
    Execute:Pointer;
  End;

  PCPPClass = ^TCPPClass;
  TCPPClass = Record
    vtable:Pointer;
    _Plugin:TMS3DPlugIn;
  End;

Procedure Plugin_Destroy(); Pascal;
Var
  myself: PCPPClass;
Begin
Asm
  mov myself, ECX;
End;
  If Assigned(Myself._Plugin) Then
  Begin
    Myself._Plugin.Destroy();
    Myself._Plugin := Nil;
  End;
End;

Function Plugin_GetType():Integer; Pascal;
Var
  myself: PCPPClass;
Begin
Asm
  mov myself, ECX;
End;
  If Assigned(Myself._Plugin) Then
    Result := Myself._Plugin.GetType()
  Else
    Result := 0;
End;

Function Plugin_GetTitle():PAnsiChar; Pascal;
Var
  myself: PCPPClass;
Begin
Asm
  mov myself, ECX;
End;
  If Assigned(Myself._Plugin) Then
    Result := PAnsiChar(Myself._Plugin.GetName())
  Else
    Result := 'Untitled';
End;

Function Plugin_Execute(Model:PmsModel):Integer; Pascal;
Var
  myself: PCPPClass;
Begin
Asm
  mov myself, ECX;
End;
  If Assigned(Myself._Plugin) Then
    Result := Myself._Plugin.Execute(Model)
  Else
    Result := 0;
End;

Var
  VMT:PluginVMT;
  PluginInstance:TCPPClass;

Function CreatePlugIn():PCPPClass; StdCall;
Begin
  VMT.Destroy := @Plugin_Destroy;
  VMT.GetType := @Plugin_GetType;
  VMT.GetTitle := @Plugin_GetTitle;
  VMT.Execute := @Plugin_Execute;

  PluginInstance.vtable := @VMT;
  PluginInstance._Plugin := PluginClass.Create();
  Result := @PluginInstance;
End;

Procedure DestroyPlugIn(plugin:PCPPClass); StdCall;
Begin
  If Assigned(Plugin._Plugin) Then
  Begin
    Plugin._Plugin.Destroy();
    Plugin._Plugin := Nil;
  End;
End;


Exports
  CreatePlugIn,
  DestroyPlugIn;

End.
