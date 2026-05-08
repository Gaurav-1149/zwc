# Firestore Schema

This structure is ready for mobile clients now and a future web admin panel.

## users/{userId}

```json
{
  "name": "Aarav Sharma",
  "email": "aarav@example.com",
  "phone": "+91 98765 43210",
  "address": "Indiranagar, Bengaluru",
  "ecoPoints": 2840,
  "wasteRecycledKg": 126.5,
  "streakDays": 18,
  "profileImage": "https://...",
  "createdAt": "2026-05-08T10:00:00.000Z"
}
```

Subcollections:

- `pointEvents`: awarded points with reason and timestamp.
- `certificates`: generated green certificate records.

## pickups/{pickupId}

```json
{
  "userId": "uid",
  "wasteType": "Plastic",
  "address": "Indiranagar, Bengaluru",
  "scheduledAt": "2026-05-10T09:30:00.000Z",
  "status": "pending",
  "notes": "Three cleaned bags",
  "collectorId": "collector-1",
  "tracking": {
    "latitude": 12.9784,
    "longitude": 77.6408
  }
}
```

Valid statuses: `pending`, `accepted`, `inTransit`, `completed`.

## communityPosts/{postId}

```json
{
  "authorId": "uid",
  "authorName": "Meera Nair",
  "authorImage": "https://...",
  "text": "Composting demo completed.",
  "imageUrl": "https://...",
  "likes": 146,
  "comments": 24,
  "tags": ["Composting", "Apartment"],
  "createdAt": "2026-05-08T10:00:00.000Z"
}
```

Subcollections:

- `comments/{commentId}`
- `likes/{userId}`

## rewards/{rewardId}

```json
{
  "title": "Recycling Hero",
  "description": "Recycle 50 kg of dry waste.",
  "requiredPoints": 500,
  "icon": "recycling",
  "active": true
}
```

## challenges/{challengeId}

```json
{
  "title": "7-Day Segregation Sprint",
  "description": "Log segregation for a full week.",
  "points": 250,
  "startsAt": "2026-05-08T00:00:00.000Z",
  "endsAt": "2026-05-15T00:00:00.000Z"
}
```

## reports/{reportId}

```json
{
  "type": "illegal_dumping",
  "userId": "uid",
  "description": "Overflowing public bin.",
  "imageUrl": "https://...",
  "status": "open",
  "createdAt": "2026-05-08T10:00:00.000Z"
}
```

## recyclingCenters/{centerId}

```json
{
  "name": "GreenLoop Recycling Hub",
  "type": "Dry Waste Center",
  "address": "12 CMH Road, Bengaluru",
  "phone": "+91 98765 11111",
  "rating": 4.7,
  "location": {
    "latitude": 12.9784,
    "longitude": 77.6408
  },
  "acceptedWasteTypes": ["Dry Waste", "Plastic", "Metal"]
}
```

## Security Rule Direction

- Users can read and update only their own `users/{userId}` profile.
- Users can create pickups where `request.auth.uid == userId`.
- Users can read public guide, rewards, challenge, and recycling center data.
- Community posts are public-read, authenticated-create, owner-update/delete.
- Admin SDK or custom claims should control writes to `rewards`, `reports.status`, center listings, and pickup status transitions.
