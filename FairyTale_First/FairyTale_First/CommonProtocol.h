//
//  CommonProtocol.h
//  FairyTale_First
//
//  Created by Igor Kolpachkov on 05.08.12.
//
//

#import <Foundation/Foundation.h>

typedef enum _CollisionLayers{
    kCollisionLayerPlayer = 1 << 0,
    kCollisionLayerObject = 1 << 1,
    kCollisionLayerTeacher = 1 << 2,
    kCollisionLayerBonus = 1 << 3,
    kCollisionLayerPicture = 1 << 4,
    kCollisionLayerTutorialPicture = 1 << 5,
    kCollisionLayerGround = 1 << 6,
    kCollisionLayerShelf = 1 << 7,
    kCollisionLayerTable = 1 << 8,
    kCollisionLayerHeart = 1 << 9,
}CollisionLayers;

@protocol CommonProtocol <NSObject>

@end
