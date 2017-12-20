import { NativeModules } from 'react-native';

const KegaVideo = NativeModules.KegaVideo;

export class VideoTools {

    static getThumbnail(path, callback, seconds = 0) {
        
        path = path.replace("file://", "");
        
        if (KegaVideo) {
            KegaVideo.getThumbnail(path, seconds, callback);
        }
        
    }

}

export default VideoTools;