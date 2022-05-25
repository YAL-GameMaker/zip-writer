{
    "id": "43c3585c-36d8-4b04-b77d-a6a021ecd206",
    "modelName": "GMExtension",
    "mvc": "1.0",
    "name": "ZipWriter",
    "IncludedResources": [
        
    ],
    "androidPermissions": [
        
    ],
    "androidProps": false,
    "androidactivityinject": "",
    "androidclassname": "",
    "androidinject": "",
    "androidmanifestinject": "",
    "androidsourcedir": "",
    "author": "",
    "classname": "",
    "copyToTargets": -1,
    "date": "2018-09-03 05:05:50",
    "description": "",
    "extensionName": "",
    "files": [
        {
            "id": "070c7699-86cb-40b9-abc7-c10ddf8019d1",
            "modelName": "GMExtensionFile",
            "mvc": "1.0",
            "ProxyFiles": [
                
            ],
            "constants": [
                
            ],
            "copyToTargets": -1,
            "filename": "zip_writer.gml",
            "final": "",
            "functions": [
                {
                    "id": "8fdb62b1-7b6d-c306-179b-7c7a101574b3",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": -1,
                    "args": [
                        
                    ],
                    "externalName": "zip_std_Date_now",
                    "help": "",
                    "hidden": true,
                    "kind": 2,
                    "name": "zip_std_Date_now",
                    "returnType": 2
                },
                {
                    "id": "1dc8a3fe-db60-2fce-9531-a94360ef59b7",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": -1,
                    "args": [
                        
                    ],
                    "externalName": "zip_std_Date_create",
                    "help": "",
                    "hidden": true,
                    "kind": 2,
                    "name": "zip_std_Date_create",
                    "returnType": 2
                },
                {
                    "id": "f5f85502-3c45-705b-5c7e-53039ed69c20",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": -1,
                    "args": [
                        
                    ],
                    "externalName": "zip_impl_crc32",
                    "help": "",
                    "hidden": true,
                    "kind": 2,
                    "name": "zip_impl_crc32",
                    "returnType": 2
                },
                {
                    "id": "39559807-d48e-0e14-e504-29e8575ab2f2",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": -1,
                    "args": [
                        
                    ],
                    "externalName": "zip_impl_write",
                    "help": "",
                    "hidden": true,
                    "kind": 2,
                    "name": "zip_impl_write",
                    "returnType": 2
                },
                {
                    "id": "cb035106-a5dc-4c1a-40a8-e149dc806120",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": -1,
                    "args": [
                        
                    ],
                    "externalName": "zip_create",
                    "help": "zip_create(compressionLevel:int = -1)->zip",
                    "hidden": false,
                    "kind": 2,
                    "name": "zip_create",
                    "returnType": 2
                },
                {
                    "id": "26100bfe-0c40-c295-bf0d-fe320d953779",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "zip_destroy",
                    "help": "zip_destroy(this:zip)",
                    "hidden": false,
                    "kind": 2,
                    "name": "zip_destroy",
                    "returnType": 2
                },
                {
                    "id": "f7ef23a1-f48f-11f9-48b5-804b9f1a274d",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": -1,
                    "args": [
                        
                    ],
                    "externalName": "zip_add_buffer_ext",
                    "help": "zip_add_buffer_ext(this:zip, path:string, buf:buffer, pos:int, len:int, ?compressionLevel:int)",
                    "hidden": false,
                    "kind": 2,
                    "name": "zip_add_buffer_ext",
                    "returnType": 2
                },
                {
                    "id": "1b6f0731-170f-01b9-bafa-fd3bafcda5b1",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": -1,
                    "args": [
                        
                    ],
                    "externalName": "zip_add_buffer",
                    "help": "zip_add_buffer(this:zip, path:string, buf:buffer, ?compressionLevel:int)",
                    "hidden": false,
                    "kind": 2,
                    "name": "zip_add_buffer",
                    "returnType": 2
                },
                {
                    "id": "075485eb-d41a-8c46-9865-398cd9033e81",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": -1,
                    "args": [
                        
                    ],
                    "externalName": "zip_add_file",
                    "help": "zip_add_file(this:zip, path:string, filePath:string, ?compressionLevel:int)",
                    "hidden": false,
                    "kind": 2,
                    "name": "zip_add_file",
                    "returnType": 2
                },
                {
                    "id": "aeae620f-b898-93a5-30a9-873fae3f448e",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": -1,
                    "args": [
                        
                    ],
                    "externalName": "zip_finalize",
                    "help": "",
                    "hidden": true,
                    "kind": 2,
                    "name": "zip_finalize",
                    "returnType": 2
                },
                {
                    "id": "6d1b24bb-e001-a8de-faa2-7e2842717c03",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        2,
                        2
                    ],
                    "externalName": "zip_save",
                    "help": "zip_save(this:zip, path:string)\/\/ Finalizes and saves the contents of this ZIP to given file",
                    "hidden": false,
                    "kind": 2,
                    "name": "zip_save",
                    "returnType": 2
                },
                {
                    "id": "42315cfa-9b70-a440-2498-3c81149a6141",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "zip_get_buffer",
                    "help": "zip_get_buffer(this:zip)->buffer\/\/ Finalizes and returns this ZIP's buffer (note: destroyed by zip_destroy - make a copy)",
                    "hidden": false,
                    "kind": 2,
                    "name": "zip_get_buffer",
                    "returnType": 2
                },
                {
                    "id": "21ca630c-b73b-7daf-c44c-4b9cc4528195",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": -1,
                    "args": [
                        
                    ],
                    "externalName": "zip_std_haxe_class_create",
                    "help": "",
                    "hidden": true,
                    "kind": 2,
                    "name": "zip_std_haxe_class_create",
                    "returnType": 2
                }
            ],
            "init": "",
            "kind": 2,
            "order": [
                "f5f85502-3c45-705b-5c7e-53039ed69c20",
                "39559807-d48e-0e14-e504-29e8575ab2f2",
                "cb035106-a5dc-4c1a-40a8-e149dc806120",
                "26100bfe-0c40-c295-bf0d-fe320d953779",
                "f7ef23a1-f48f-11f9-48b5-804b9f1a274d",
                "1b6f0731-170f-01b9-bafa-fd3bafcda5b1",
                "075485eb-d41a-8c46-9865-398cd9033e81",
                "aeae620f-b898-93a5-30a9-873fae3f448e",
                "6d1b24bb-e001-a8de-faa2-7e2842717c03",
                "42315cfa-9b70-a440-2498-3c81149a6141"
            ],
            "origname": "",
            "uncompress": false
        }
    ],
    "gradleinject": "",
    "helpfile": "",
    "installdir": "",
    "iosProps": false,
    "iosSystemFrameworkEntries": [
        
    ],
    "iosThirdPartyFrameworkEntries": [
        
    ],
    "iosplistinject": "",
    "license": "",
    "maccompilerflags": "",
    "maclinkerflags": "",
    "macsourcedir": "",
    "packageID": "",
    "productID": "",
    "sourcedir": "",
    "version": "0.0.1"
}