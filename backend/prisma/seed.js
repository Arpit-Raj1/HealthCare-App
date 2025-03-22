const { PrismaClient } = require('@prisma/client');

const prisma = new PrismaClient();

// async function main() {
//     await prisma.user.create({
//         data: {
//             name: 'John Doe',
//             email: 'john.doe@example.com',
//             password: 'securepassword123',
//             phoneNumber: '1234567890',
//             role: 'PATIENT',
//             dob: new Date('1990-01-01'),
//         },
//     });

//     console.log('User seeded successfully');
// }

async function getUserByEmail(email) {
    const user = await prisma.user.findUnique({
        where: {
            email: email,
        },
    });
    return user;
}

// Example usage
getUserByEmail('john.doe@example.com')
    .then((user) => {
        console.log(user);
    })
    .catch((error) => {
        console.error(error);
    });

// main()
//     .catch((e) => {
//         console.error(e);
//         process.exit(1);
//     })
//     .finally(async () => {
//         await prisma.$disconnect();
//     });
