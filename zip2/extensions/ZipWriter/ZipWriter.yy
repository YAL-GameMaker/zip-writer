{
    "name": "ZipWriter",
    "description": "",
    "androidPermissions": [],
    "androidmanifestinject": "",
    "sourcedir": "",
    "copyToTargets": -1,
    "mvc": "1.0",
    "androidinject": "",
    "androidProps": false,
    "maccompilerflags": "",
    "iosProps": false,
    "IncludedResources": [],
    "productID": "",
    "helpfile": "",
    "macsourcedir": "",
    "id": "43c3585c-36d8-4b04-b77d-a6a021ecd206",
    "gradleinject": "",
    "iosplistinject": "",
    "classname": "",
    "androidclassname": "",
    "maclinkerflags": "",
    "iosSystemFrameworkEntries": [],
    "files": [
        {
            "constants": [],
            "copyToTargets": -1,
            "ProxyFiles": [],
            "mvc": "1.0",
            "init": "",
            "functions": [
                {
                    "name": "zip_impl_crc32",
                    "externalName": "zip_impl_crc32",
                    "help": "",
                    "mvc": "1.0",
                    "id": "f5f85502-3c45-705b-5c7e-53039ed69c20",
                    "kind": 2,
                    "argCount": -1,
                    "modelName": "GMExtensionFunction",
                    "returnType": 2,
                    "hidden": false,
                    "args": []
                },
                {
                    "name": "zip_impl_write",
                    "externalName": "zip_impl_write",
                    "help": "",
                    "mvc": "1.0",
                    "id": "39559807-d48e-0e14-e504-29e8575ab2f2",
                    "kind": 2,
                    "argCount": -1,
                    "modelName": "GMExtensionFunction",
                    "returnType": 2,
                    "hidden": false,
                    "args": []
                },
                {
                    "name": "zip_create",
                    "externalName": "zip_create",
                    "help": "zip_create(compressionLevel:int = -1)",
                    "mvc": "1.0",
                    "id": "cb035106-a5dc-4c1a-40a8-e149dc806120",
                    "kind": 2,
                    "argCount": -1,
                    "modelName": "GMExtensionFunction",
                    "returnType": 2,
                    "hidden": false,
                    "args": []
                },
                {
                    "name": "zip_destroy",
                    "externalName": "zip_destroy",
                    "help": "zip_destroy(this:zip)",
                    "mvc": "1.0",
                    "id": "26100bfe-0c40-c295-bf0d-fe320d953779",
                    "kind": 2,
                    "argCount": 1,
                    "modelName": "GMExtensionFunction",
                    "returnType": 2,
                    "hidden": false,
                    "args": [
                        2
                    ]
                },
                {
                    "name": "zip_add_buffer_ext",
                    "externalName": "zip_add_buffer_ext",
                    "help": "zip_add_buffer_ext(this:zip, path:string, buf:buffer, pos:int, len:int)",
                    "mvc": "1.0",
                    "id": "f7ef23a1-f48f-11f9-48b5-804b9f1a274d",
                    "kind": 2,
                    "argCount": 5,
                    "modelName": "GMExtensionFunction",
                    "returnType": 2,
                    "hidden": false,
                    "args": [
                        2,
                        2,
                        2,
                        2,
                        2
                    ]
                },
                {
                    "name": "zip_add_buffer",
                    "externalName": "zip_add_buffer",
                    "help": "zip_add_buffer(this:zip, path:string, buf:buffer)",
                    "mvc": "1.0",
                    "id": "1b6f0731-170f-01b9-bafa-fd3bafcda5b1",
                    "kind": 2,
                    "argCount": 3,
                    "modelName": "GMExtensionFunction",
                    "returnType": 2,
                    "hidden": false,
                    "args": [
                        2,
                        2,
                        2
                    ]
                },
                {
                    "name": "zip_add_file",
                    "externalName": "zip_add_file",
                    "help": "zip_add_file(this:zip, path:string, filePath:string)",
                    "mvc": "1.0",
                    "id": "075485eb-d41a-8c46-9865-398cd9033e81",
                    "kind": 2,
                    "argCount": 3,
                    "modelName": "GMExtensionFunction",
                    "returnType": 2,
                    "hidden": false,
                    "args": [
                        2,
                        2,
                        2
                    ]
                },
                {
                    "name": "zip_finalize",
                    "externalName": "zip_finalize",
                    "help": "",
                    "mvc": "1.0",
                    "id": "aeae620f-b898-93a5-30a9-873fae3f448e",
                    "kind": 2,
                    "argCount": -1,
                    "modelName": "GMExtensionFunction",
                    "returnType": 2,
                    "hidden": false,
                    "args": []
                },
                {
                    "name": "zip_save",
                    "externalName": "zip_save",
                    "help": "zip_save(this:zip, path:string) : Finalizes and saves the contents of this ZIP to given file",
                    "mvc": "1.0",
                    "id": "6d1b24bb-e001-a8de-faa2-7e2842717c03",
                    "kind": 2,
                    "argCount": 2,
                    "modelName": "GMExtensionFunction",
                    "returnType": 2,
                    "hidden": false,
                    "args": [
                        2,
                        2
                    ]
                },
                {
                    "name": "zip_get_buffer",
                    "externalName": "zip_get_buffer",
                    "help": "zip_get_buffer(this:zip)->buffer : Finalizes and returns this ZIP's buffer (note: destroyed by zip_destroy - make a copy)",
                    "mvc": "1.0",
                    "id": "42315cfa-9b70-a440-2498-3c81149a6141",
                    "kind": 2,
                    "argCount": 1,
                    "modelName": "GMExtensionFunction",
                    "returnType": 2,
                    "hidden": false,
                    "args": [
                        2
                    ]
                }
            ],
            "origname": "",
            "final": "",
            "id": "070c7699-86cb-40b9-abc7-c10ddf8019d1",
            "kind": 2,
            "uncompress": false,
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
            "modelName": "GMExtensionFile",
            "filename": "zip_writer.gml"
        }
    ],
    "version": "0.0.1",
    "installdir": "",
    "author": "",
    "androidsourcedir": "",
    "modelName": "GMExtension",
    "packageID": "",
    "androidactivityinject": "",
    "iosThirdPartyFrameworkEntries": [],
    "date": "2018-09-03 05:05:50",
    "extensionName": "",
    "license": ""
}