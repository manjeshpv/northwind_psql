const {Client} = require('pg');

async function createForeignTablePg(pgClient, schema, table, server) {
    const reporting_server_schema = 'public';
    const query = `IMPORT FOREIGN SCHEMA ${schema} LIMIT TO (${table}) FROM SERVER ${server} INTO ${reporting_server_schema};`;
    console.log({query})
    try {
        await pgClient.query(query);
        console.log(`Successfully imported schema ${schema}.${table} from PostgreSQL foreign server.`);
    } catch (error) {
        console.error(`Error importing schema from PostgreSQL foreign server:`, error);
    }
}

async function reporting() {

    console.log('main')
    const options = {
        host: "localhost",
        database: "reporting",

        user: "postgres",
        password: "postgres",
        port: 45432,
    }
    const pgClient = new Client(options);


    try {
        await pgClient.connect();


        await createForeignTablePg(pgClient, 'yhms_medical' || options.database, 'newtable', 'remote_pg_server' || 'consent' || options.host);

    } catch (error) {
        console.error("Error in main execution:", error);
    } finally {
        await pgClient.end();
    }
}


reporting();


