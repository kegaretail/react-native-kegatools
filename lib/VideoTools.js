import { NativeModules } from 'react-native';

const KegaVideo = NativeModules.KegaVideo;

export class VideoTools {

    static getThumbnail(path, callback) {
        
        path = path.replace("file://", "");
        
        if (KegaVideo) {
            KegaVideo.getThumbnail(path, callback);
        }
        
    }

}

export default VideoTools;