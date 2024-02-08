import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

enum MealType {
  Breakfast = 'breakfast',
  Lunch = 'lunch',
  Dinner = 'dinner',
  Snack = 'snack',
}

enum Diet {
  Vegetarian = 'vegetarian',
  Vegan = 'vegan',
  LactoseFree = 'lactose-free',
  GlutenFree = 'gluten-free',
  Healthy = 'healthy',
  HighProtein = 'high-protein',
  LowCarb = 'low-carb',
}

type PromptParams = {
  mealType: MealType,
  diet: Diet[],
  time: number,
  ingredients: string[],
  extendRecipe: boolean,
}

const promptTransformer = (params: PromptParams) =>
    `Please give me a meal recipe that can be done in under ${params.time} minutes.
    Here are available ingredients: ${params.ingredients.join(', ')}, and some spices.
    The diet preferences: ${params.diet.join(', ')}.
    ${params.extendRecipe ? 'You can add one or two ingredients not provided in the list, if you came up with the great one.' : ''}
    Return the result in JSON format with following structure:
    {
      "name": "recipe name",
      "ingredients": [{"name": "ingredient1", "quantity": "quantity", "emoji": "emoji"}],
      "instructions": ["instruction1", "instruction2"],
      "diets": ["diet type"],
      "mealType": "meal type",
      "time": 10,
      "servings": 2
    }
    
    Return appropriate emoji for each ingredient.
    Don't include numeration in the instructions list.
    Make sure that the result is a valid JSON object.
    Keep the result under 1000 characters.`;

const supabase = createClient(Deno.env.get('SUPABASE_URL') || 'supabase-false-url',
                              Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') || 'supabase-false-key',
                              { db: { schema: 'public' } });

const OPENAI_API_KEY = Deno.env.get('OPENAI_API_KEY') || 'opeai-false-key'
const requestHandlerOpts = Deno.env.get('DEV') ?
  {
    port: 8080,
    onListen: ({ hostname, port }: {hostname: string, port: number}) => {
      console.log(`\nServer started at ${hostname}:${port}`)
    }
  } : {}

const CORS_HEADERS = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': '*',
}

const generateRecipe = async (params: PromptParams) => {
  const prompt = promptTransformer(params)
  console.log('params', JSON.stringify(params), prompt)
  const requestBody = JSON.stringify({
    model: 'gpt-3.5-turbo',
    temperature: 0.3,
    max_tokens: 1000,
    messages: [{
      role: 'user',
      content: [{"type": "text", "text": prompt},]
    }]
  })

  try {
    const res = await fetch('https://api.openai.com/v1/chat/completions', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${OPENAI_API_KEY}`
      },
      body: requestBody
    })

    console.log('OpenAI response', res)
    const data = await res.json()
    console.log(`OpenAI response for '${JSON.stringify(params)}', ${data.choices.length}`, data.choices[0].message.content)

    const recipe = JSON.parse(data.choices[0].message.content)

    // const imageRes = await fetch('https://api.openai.com/v1/images/generations', {
    //   method: 'POST',
    //   headers: {
    //     'Content-Type': 'application/json',
    //     'Authorization': `Bearer ${OPENAI_API_KEY}`
    //   },
    //   body: JSON.stringify({
    //     "model": "dall-e-3",
    //     "prompt": `Super realistic image of a dish: ${recipe.name} including those ingredients ${recipe.ingredients.map((i: any) => i.name).join(', ')}.`,
    //     "n": 1,
    //     "size": "1024x1024"
    //   })
    // })

    // const imageData = await imageRes.json();

    // console.log('imageRes', imageRes, imageData)
    return {
      ...recipe,
      diets: params.diet,
      mealType: params.mealType,
      time: params.time,
      image: ""
    }
  } catch (err) {
    console.log('Error when fetching/parsing OpenAI request')
    console.log('Request body:', requestBody)
    console.log('Error: ', err)

    return null
  }
}

Deno.serve(async (req) => {
  console.log("Method:", req.method);
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: CORS_HEADERS })
  }

  try {
    const body: PromptParams = await req.json();
    const recipe = await generateRecipe(body);
  
    console.log('recipe', JSON.stringify(recipe));
    // Bad request
    return new Response(JSON.stringify(recipe), { headers: { 'Content-Type': 'application/json', ...CORS_HEADERS } });  
  } catch (error) {
    console.error(error);
    return new Response(error.message, { status: error.status ?? 500, headers: CORS_HEADERS });
  }

})

/* To invoke locally:

  1. Run `supabase start` (see: https://supabase.com/docs/reference/cli/supabase-start)
  2. Make an HTTP request:

  curl -i --location --request POST 'http://127.0.0.1:54321/functions/v1/get-recipe' \
    --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0' \
    --header 'Content-Type: application/json' \
    --data '{"name":"Functions"}'

*/