require('SWGApi,SWGApiClient')
//var ServerURL = "http://114.215.152.69/php/api";
//defineClass('SWGApi',{
//            
//            
//            }, {
//            // replace the -genView method
//            apiWithBasePath:function(basePath){
////            [[self alloc] initWithBasePath:basePath];
//                return self.alloc().initWithBasePath("http://114.215.152.69/php/api")
//            }
//            });
defineClass('NoteBookWeeklyService', {
            // replace the -genView method
        
            
            init:function(){
//            self = self.super().init()
            var api = self.valueForKey("_api")
//            if(self = self.super().init()){
            
                api = require('SWGWeeklyApi').apiWithBasePath("http://114.215.152.69/php/api")
                self.setValue_forKey(api, "_api")
//            }
            
            return self;
            
            }
            });