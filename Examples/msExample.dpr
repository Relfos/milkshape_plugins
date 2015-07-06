Library Example1;

uses
  Windows, MilkshapePlugin, TERRA_String;

Type
  ExamplePlugin = Class(TMS3DPlugIn)
    Public
      Function GetType():Integer; Override;
      Function GetName():TERRAString; Override;
      Function Execute(Model:PmsModel):Integer; Override;
    End;

{ ExamplePlugin }

Function ExamplePlugin.Execute(Model: PmsModel): Integer;
Begin
  MessageBox(0, 'Test', 'Test', MB_OK);
End;

Function ExamplePlugin.GetName: TERRAString;
Begin
  Result := 'Example Plugin';
End;

Function ExamplePlugin.GetType: Integer;
Begin
  Result := pluginTypeFace;
End;

Begin
  PluginClass := ExamplePlugin;
End.
 