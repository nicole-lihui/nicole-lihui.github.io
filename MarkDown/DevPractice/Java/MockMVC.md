# MockMVC

## Demo
```Java
// Controller
@RestController
public class DemoController {

    @RequestMapping("/user/{name}/access")
    public String getInfo(@PathVariable String name) {
        return name + " : account";
    }

    @GetMapping("/user")
    public String show(String name) {
        return "Hello," + name + " !";
    }

    @PostMapping("/user")
    public String show(@RequestBody User user) {
        return user.toString();
    }
}

// Test
@RunWith(SpringRunner.class)
@SpringBootTest
public class DemoControllerTests {

    @Autowired
    WebApplicationContext wac;
    MockMvc mockMvc;

    @Test
    public void testDemoController() throws Exception {
        mockMvc = MockMvcBuilders.webAppContextSetup(wac).build();

        MvcResult pathRes = mockMvc.perform(
                MockMvcRequestBuilders
                .get("/user/nicole/access"))
            .andExpect(MockMvcResultMatchers.status().isOk())
            .andReturn();
        System.out.println(pathRes.getResponse().getContentAsString());

        MvcResult fromRes = mockMvc.perform(
                MockMvcRequestBuilders
                .get("/user")
                .contentType(MediaType.APPLICATION_FORM_URLENCODED)
                .param("name", "Nicole"))
            .andExpect(MockMvcResultMatchers.status().isOk())
            .andDo(MockMvcResultHandlers.print())
            .andReturn();
        System.out.println(fromRes.getResponse().getContentAsString());

        ObjectMapper om = new ObjectMapper();
        User u = new User(1, "Nicole");
        String uStr = om.writeValueAsString(u);
        MvcResult jsonRes = mockMvc.perform(MockMvcRequestBuilders
                .post("/user")
                .contentType(MediaType.APPLICATION_JSON)
                .content(uStr))
            .andExpect(MockMvcResultMatchers.status().isOk())
            .andReturn();
        System.out.println(jsonRes.getResponse().getContentAsString());
    }
}
```
> WebApplicationContext 模拟SevletContext环境
